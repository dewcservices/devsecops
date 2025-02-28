FROM registry.access.redhat.com/ubi9/ubi:latest

# Install git, nano, java maven
RUN dnf install git nano java-21-openjdk maven -y

# Install nodejs for SonarQube 
RUN dnf install nodejs -y