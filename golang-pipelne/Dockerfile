FROM registry.access.redhat.com/ubi9/ubi:latest AS base

ARG USER_ID=1001
ARG GROUP_ID=1001
ENV USER_NAME=default

ENV HOME="/app"
ENV PATH="/app/.local/bin:${PATH}"


USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano & golang
dnf install git nano delve golang golang-docs golang-tests -y; \
# clear cache
dnf clean all

WORKDIR ${HOME}

# Create user and set permissions
RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -u ${USER_ID} -r -g ${USER_NAME} -d ${HOME} -s /bin/bash ${USER_NAME} 

#-----------------------------

# Dev target
FROM base AS dev
COPY .devcontainer/devtools.sh /tmp/devtools.sh
# Install extra dev tools as root, then run as default user
RUN chmod +x devtools.sh && /tmp/devtools.sh  
USER ${USER_NAME}

# DEPLOYMENT EXAMPLE:
#-----------------------------

# Prod target
FROM base

## Move to app folder, copy project into container
WORKDIR ${HOME}

## REPLACE: replace this COPY statement with project specific files/folders
COPY . .

# Check home
RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME} && \
    chmod -R 0750 ${HOME}

USER ${USER_NAME}

## Install project requirements, build project
RUN go mod download; \
go build -o /app/run

## Expose port and run app
EXPOSE 8080
CMD [ "/app/run" ]