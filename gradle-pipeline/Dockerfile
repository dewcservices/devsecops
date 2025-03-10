FROM registry.access.redhat.com/ubi9/ubi:latest

RUN dnf update -y; \
# Install git, nano & java 
dnf install git nano java-21-openjdk -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
rm -rf /var/cache