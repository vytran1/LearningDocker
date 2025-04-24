#!/bin/bash

# Variables
CONTAINER_NAME="mongodb"
IMAGE_NAME="mongodb/mongodb-community-server:7.0-ubuntu2204"
NETWORK_NAME="key-value-net"
VOLUME_NAME="key-value-data"
HOST_PORT=27017
ROOT_USER="root-user"
ROOT_PASSWORD="root-password"

# Start MongoDB container
docker run -d --name $CONTAINER_NAME \
  -e MONGODB_INITDB_ROOT_USERNAME=$ROOT_USER \
  -e MONGODB_INITDB_ROOT_PASSWORD=$ROOT_PASSWORD \
  -p $HOST_PORT:27017 \
  -v $VOLUME_NAME:/data/db \
  --network $NETWORK_NAME \
  $IMAGE_NAME

# Wait a bit for MongoDB to start up
echo "⏳ Waiting for MongoDB to initialize..."
sleep 10

# Copy JS script into container
docker cp mongo-init.js $CONTAINER_NAME:/mongo-init.js

# Execute JS script inside MongoDB container
docker exec -it $CONTAINER_NAME mongosh -u $ROOT_USER -p $ROOT_PASSWORD --authenticationDatabase admin /mongo-init.js
