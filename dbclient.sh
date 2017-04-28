#!/bin/bash

#### THIS IS A POSTGRES CLIENT WRAPPER TO ACCESS PG DBMS ####

if [ -z "$DATABASE_USERNAME_DEVELOPMENT" ]; then
	echo "\$DATABASE_USERNAME_DEVELOPMENT not found, need to export .env file again!"
	exit 1
fi

if [ -z "$DATABASE_USERNAME_TEST" ]; then
	echo "\$DATABASE_USERNAME_TEST not found, need to export .env file again!"
	exit 1
fi

if [ -z "$HOST_DEVELOPMENT" ]; then
	echo "\$HOST_DEVELOPMENT not found, need to export .env file again!"
	exit 1
fi

if [ -z "$HOST_TEST" ]; then
	echo "\$HOST_TEST not found, need to export .env file again!"
	exit 1
fi

echo "This is a postgres client wrapper to access postgres dbms"
echo "*** Please make sure you export .env first before running this script ***"
echo "Which environment you are running from?"
echo "(0) Development"
echo "(1) Test"
echo "(2) Production"
echo "--------------"

echo -n "Enter a number and press [ENTER]: "
read choice

if [ $choice -eq 0 ]; then
	psql -h $HOST_DEVELOPMENT -U $DATABASE_USERNAME_DEVELOPMENT
fi

if [ $choice -eq 1 ]; then
	psql -h $HOST_TEST -U $DATABASE_USERNAME_TEST
fi

if [ $choice -eq 2 ]; then
	psql -h $HOST_PRODUCTION -U $DATABASE_USERNAME_PRODUCTION
fi
