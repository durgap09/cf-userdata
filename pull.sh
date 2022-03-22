#!/bin/bash

ACC_ID=$(aws ssm get-parameter --name "ACC_ID" --region us-east-2 --query 'Parameter.Value' --output text)

apt install awscli -y

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $ACC_ID.dkr.ecr.us-east-2.amazonaws.com

docker pull $ACC_ID.dkr.ecr.us-east-2.amazonaws.com/qcloud-backend:latest

docker pull $ACC_ID.dkr.ecr.us-east-2.amazonaws.com/qcloud-postgres:latest

docker pull $ACC_ID.dkr.ecr.us-east-2.amazonaws.com/qcloud-pulumi:latest

docker pull $ACC_ID.dkr.ecr.us-east-2.amazonaws.com/qcloud-frontend:latest

docker volume create qcloud-db

docker volume create qcloud-backend

docker network create appmodz
