FROM registry.access.redhat.com/ubi9/ubi:latest

# Install git, nano, python & poetry
RUN dnf install git nano python3 -y
curl -sSL https://install.python-poetry.org | python3 -

# Install nodejs for SonarQube 
RUN dnf install nodejs