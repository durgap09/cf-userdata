#!/bin/bash

cd /home/ubuntu/

# First running the DB container
echo "Starting Postgres Database Container"
sudo docker run --net appmodz --name postgres_db -v qcloud-db:/var/lib/postgresql/data/ -p 5432:5432 --env-file /home/ubuntu/.env -t -d 456325780689.dkr.ecr.us-east-2.amazonaws.com/qcloud-postgres:latest

docker ps -a

# Secont running the Pulumi Container
echo "Starting Pulumi Backend Container"
sudo docker run -t --net appmodz --name pulumi_bknd -v qcloud-backend:/home/ -p 3000:6792 --env-file /home/ubuntu/.env -d 456325780689.dkr.ecr.us-east-2.amazonaws.com/qcloud-pulumi:latest

sudo docker ps -a

# Third running the React-Frontend Container
echo "Starting React Frontend Container"
sudo docker run --name react-frontend -d -p 3005:80 --env-file /home/ubuntu/.env -t 456325780689.dkr.ecr.us-east-2.amazonaws.com/qcloud-frontend:latest

sudo docker ps -a

# Building the Backend with Tomcat Image
echo "Building the Tomcat Backend Image"
sudo docker build /home/ubuntu/ -t backend

# Finallyy running the Springboot Backend container
echo "Starting Springboot Backend Container"
sudo docker run --net appmodz --name springboot -v  qcloud-backend:/home/ -t -p 3006:8080 -d backend

docker ps -a

# Starting the Nginx Proxy Manager
sudo docker-compose up -d

docker ps -a

# This command is for PG restore that is to restore the data from dump/.bak file to the Postgres Database
sudo docker exec -it -d postgres_db bash -c "pg_restore -h localhost -p 5432 -U exec_module -d exec_module -v /docker-entrypoint-initdb.d/latest3.bak"

exit
