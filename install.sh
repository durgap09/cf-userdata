#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install docker.io -y
sudo apt install docker-compose -y
sudo apt update -y
sudo apt install ruby-full -y
sudo apt install wget -y
wget https://aws-codedeploy-us-east-2.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto > /tmp/logfile
sudo service codedeploy-agent start
sudo service codedeploy-agent status
