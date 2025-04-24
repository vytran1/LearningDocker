#!/bin/bash

MONGODB_IMAGE="mongodb/mongodb-community-server"
MONGODB_TAG="7.0-ubuntu2204"
source .env.db


# ROOT credentials
ROOT_USER="root-user"
ROOT_PASSWORD="root-password"

# Key-value credentials
KEY_VALUE_DB="key-value-db"
KEY_VALUE_USER="key-value-user"
KEY_VALUE_PASSWORD="key-value-password"

# Connectivity
LOCALHOST_PORT=27017
CONTAINER_PORT=27017
source .env.network


#Storage
source .env.volume
VOLUME_CONTAINER_PATH="/data/db"

INIT_JS_ABS_PATH=$(realpath ./db-config/mongo-init.js)


source setup.sh

if [ "$(docker ps -q -f name=$DB_CONTAINER_NAME)" ]; then
  echo "A container with the name $DB_CONTAINER_NAME already exists"
  exit 1
fi  

docker run --rm -d --name $DB_CONTAINER_NAME \
  -e MONGODB_INITDB_ROOT_USERNAME=$ROOT_USER \
  -e MONGODB_INITDB_ROOT_PASSWORD=$ROOT_PASSWORD \
  -e KEY_VALUE_DB=$KEY_VALUE_DB \
  -e KEY_VALUE_USER=$KEY_VALUE_USER \
  -e KEY_VALUE_PASSWORD=$KEY_VALUE_PASSWORD \
  -p $LOCALHOST_PORT:$CONTAINER_PORT \
  -v $VOLUME_NAME:$VOLUME_CONTAINER_PATH \
  -v "/d/LearningDockerAndKubenetes/key-and-value-app/db-config/mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js:ro" \
  --network $NETWORK_NAME \
  $MONGODB_IMAGE:$MONGODB_TAG