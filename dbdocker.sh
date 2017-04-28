#!/bin/bash

##### DISCLAIMER: RUN THIS SCRIPT BEFORE LAUNCHNG YOUR RAIL SERVER     ########
##### THIS SCRIPT IS TO MAKE SURE DOCKER PG CONTAINER RUNNING PROPERLY ########
##### UNDER CORRECT POSTGRES_USER NAME AND PASSWORD AND PORT, ETC      ########
##### IDEALLY USED FOR DEVELOPMENT AND TESTING ENVIRONMENT             ########


if [ -z "$DATABASE_PORT" ]; then
	echo "\$DATABASE_PORT not found, need to export .env file again!"
	exit 1
fi

if [ -z "$DOCKER_CONTAINER_NAME" ]; then
	echo "\$DOCKER_CONTAINER_NAME not found, need to export .env file again!"
	exit 1
fi
 
echo "Which environment do you want to run dbdocker?"
echo "(0) Development"
echo "(1) Test"
echo "(2) Production"
echo "--------------"

echo -n "Enter a number and press [ENTER]: "
read choice

REAL_CONTAINER_NAME=

if [ $choice -eq 0 ]; then
	REAL_CONTAINER_NAME=${DOCKER_CONTAINER_NAME}_dev
elif [ $choice -eq 1 ]; then
	REAL_CONTAINER_NAME=${DOCKER_CONTAINER_NAME}_test
elif [ $choice -eq 2 ]; then
	REAL_CONTAINER_NAME=${DOCKER_CONTAINER_NAME}_prod
fi


if [ ! "$(sudo docker ps -a | grep $REAL_CONTAINER_NAME)" ]; then
	sudo docker run --name $REAL_CONTAINER_NAME -p $DATABASE_PORT:$DATABASE_PORT -e POSTGRES_USER=$DATABASE_USERNAME_DEVELOPMENT postgres
else
	sudo docker start $REAL_CONTAINER_NAME
fi

sudo docker ps
echo "#### postgres docker container is running... #####"
echo "#### Its time to run your rail server now... #####"
