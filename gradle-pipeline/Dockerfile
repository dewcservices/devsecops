FROM registry.access.redhat.com/ubi9/ubi:latest

ARG dev=false
ENV container oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano & java 
dnf install git nano java-21-openjdk -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
dnf clean all

FROM base AS dev
COPY .devcontainer/devtools.sh /tmp/devtools.sh
RUN  /tmp/devtools.sh
USER default
#---
FROM base
USER default


# OPTIONAL DEPLOYMENT EXAMPLE:
#-----------------------------

## Install tomcat server (EXAMPLE)
# RUN wget https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.5/bin/apache-tomcat-11.0.5.tar.gz
# RUN tar xvf apache-tomcat-*.tar.gz
# RUN mv apache-tomcat-11.0.5 /usr/local/tomcat11/
# RUN <<EOF cat >> /usr/local/tomcat11/conf/tomcat-users.xml
#   <tomcat-users>
#       <role rolename="manager-gui"/>
#       <role rolename="admin-gui"/>
#       <user username="podman" password="podman" roles="manager-gui,admin-gui"/>
#   </tomcat-users>
# EOF

## Make App folder, copy project into container
# WORKDIR /app
# COPY . .

## Install project requirements, build project
# RUN ./gradlew clean build
# RUN cp /build/libs/*.war /usr/local/tomcat11/webapps/

## Expose port and run app
# EXPOSE 8080
# CMD [ "/usr/local/tomcat11/bin/startup.sh"  ]