source .env.db
source .env.volume
source .env.network

if [ "$(docker ps -aq -f name=$DB_CONTAINER_NAME)" ]; then
    echo "Removing DB container $DB_CONTAINER_NAME"
    docker kill $DB_CONTAINER_NAME
else
    echo "A container with the name $DB_CONTAINER_NAME not exists"    
fi  


if [ "$(docker volume ls -q -f name=$VOLUME_NAME)" ]; then
    docker volume rm $VOLUME_NAME
else
    echo "A volume with $VOLUME_NAME not exist"
fi

if [ "$(docker network ls -q -f name=$NETWORK_NAME)" ]; then
    docker network rm $NETWORK_NAME
else
    echo "A network with $NETWORK_NAMR not exist"
fi