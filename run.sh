#!/bin/bash

wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

sudo dpkg -i amazon-cloudwatch-agent.deb

sudo mv config.json /opt/aws/amazon-cloudwatch-agent/bin/

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a status

bash install.sh

bash ssm_parameter.sh

bash pull.sh

bash start.sh
