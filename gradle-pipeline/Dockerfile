FROM registry.access.redhat.com/ubi9/ubi:latest AS base


ENV container=oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano & java 
dnf install git nano java-21-openjdk -y; \
# clear cache
dnf clean all

# Dev target
FROM base AS dev
COPY .devcontainer/devtools.sh /tmp/devtools.sh
RUN  /tmp/devtools.sh
USER default

# DEPLOYMENT EXAMPLE:
#-----------------------------

# Prod target
FROM base

## Install tomcat server (EXAMPLE)
ADD https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.5/bin/apache-tomcat-11.0.5.tar.gz apache-tomcat-11.0.5.tar.gz
RUN tar xvf apache-tomcat-*.tar.gz; \
mv apache-tomcat-11.0.5 /usr/local/tomcat11/; \
<<EOF cat >> /usr/local/tomcat11/conf/tomcat-users.xml
  <tomcat-users>
      <role rolename="manager-gui"/>
      <role rolename="admin-gui"/>
      <user username="default" password="default" roles="manager-gui,admin-gui"/>
  </tomcat-users>
EOF

## Make App folder, copy project into container
WORKDIR /app
## REPLACE: replace this COPY statement with project specific files/folders
COPY . . 

## Install project requirements, build project
RUN ./gradlew clean build; \
cp /build/libs/*.war /usr/local/tomcat11/webapps/

## clarify permissions
RUN chown -R default:0 /app && \
    chmod -R g=u /app

## Expose port and run app
EXPOSE 8080
USER default
CMD [ "/usr/local/tomcat11/bin/startup.sh"  ]