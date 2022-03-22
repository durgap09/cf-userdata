FROM tomcat:9

ADD setenv.sh /usr/local/tomcat/bin/

RUN chmod u+x /usr/local/tomcat/bin/setenv.sh

CMD ["setenv.sh", "run"]

COPY --from=456325780689.dkr.ecr.us-east-2.amazonaws.com/qcloud-backend:latest /usr/local/service/target/execution-module-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/qcloud.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
