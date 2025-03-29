FROM registry.access.redhat.com/ubi9/ubi:latest

ARG dev=false
ENV container oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano & golang
dnf install git nano delve golang golang-docs golang-tests -y; \
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
## Make App folder, copy project into container
# WORKDIR /app
# COPY . .

## Install project requirements, build project
# RUN go mod download 
# RUN go build -o /app/run

## Expose port and run app
# EXPOSE 8080
# CMD [ /app/run ]