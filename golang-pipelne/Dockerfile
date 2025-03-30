FROM registry.access.redhat.com/ubi9/ubi:latest AS base


ENV container=oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano & golang
dnf install git nano delve golang golang-docs golang-tests -y; \
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

## Make App folder, copy project into container
WORKDIR /app
## REPLACE: replace this COPY statement with project specific files/folders
COPY . . 

## Install project requirements, build project
RUN go mod download; \
go build -o /app/run

## clarify permissions
RUN chown -R default:0 /app && \
    chmod -R g=u /app

## Expose port and run app
EXPOSE 8080
USER default
CMD [ "/app/run" ]