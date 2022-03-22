#!/bin/bash
URL=$(aws ssm get-parameter --name "URL" --region us-east-2 --query 'Parameter.Value' --output text)
PGUSER=$(aws ssm get-parameter --name "PGUSER" --region us-east-2 --query 'Parameter.Value' --output text)
PGPWD=$(aws ssm get-parameter --name "PGPWD" --region us-east-2 --query 'Parameter.Value' --output text)
FRNTPORT=$(aws ssm get-parameter --name "FRNTPORT" --region us-east-2 --query 'Parameter.Value' --output text)
BKNDPORT=$(aws ssm get-parameter --name "BKNDPORT" --region us-east-2 --query 'Parameter.Value' --output text)
PLMIPORT=$(aws ssm get-parameter --name "PLMIPORT" --region us-east-2 --query 'Parameter.Value' --output text)
DTBSPORT=$(aws ssm get-parameter --name "DTBSPORT" --region us-east-2 --query 'Parameter.Value' --output text)
IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

rm .env
touch .env   #creating the .env file

echo "#!/bin/sh
REACT_APP_API_URL=https://$URL/api/v1/

REACT_APP_10DUKE_PATH=https://$URL/auth

REACT_APP_HIDE_10DUKE=1

POSTGRES_USER=$PGUSER

POSTGRES_PASSWORD=$PGPWD

POSTGRES_DB=exec_module" >> .env
## Here above it is taking the values from prompt and then saving in .env

rm setenv.sh  #deleting setenv.sh

touch setenv.sh    #Creating setenv.sh

echo "#!/bin/sh
export JDBC_DRIVER_2="org.postgresql.Driver"
export JDBC_URL_2="jdbc:postgresql://$my_ip:$DTBSPORT/exec_module"
export POSTGRES_USERNAME_2="$PGUSER"
export POSTGRES_PASSWORD_2="$PGPWD"
export WORKING_DIR_2="/home/execution-module/"
export PULUMI_BASE_URL="http://$my_ip:$PLMIPORT/"
export SES_ACCESS_KEY="AKIAQCCE4QSRF6ZQOTA4"
export SES_SECRET_KEY="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"
export SES_REGION="ap-south-1"
export SES_MAIL_SENDER="support@appmodernize.com"
export CHANGE_PASSWORD_LINK="https://$URL/register/"
export FORGOT_PASSWORD_LINK="https://$URL/forgot_password/"
export LOGIN_LINK="https://$URL/login/" " >> setenv.sh
#### Capturing the inputs and saving them in setenv.sh

