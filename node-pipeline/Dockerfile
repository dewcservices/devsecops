FROM registry.access.redhat.com/ubi9/ubi:latest AS base


ENV container=oci
ENV USER=default

USER root

COPY .nvmrc .nvmrc

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# enable nodejs verson
# dnf module -y enable nodejs:$(cat .nvmrc | cut -c2-3) && \
# Install git, nano, nodejs and npm 
dnf install git nano nodejs npm -y; \
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
RUN npm install lite-server --save-dev; \
npm build --prod

## clarify permissions
RUN chown -R default:0 /app && \
    chmod -R g=u /app

## Expose port and run app
EXPOSE 8080
USER default
CMD [ "lite-server --baseDir='dist/*/'"  ]

# EXPOSE 3000
#CMD ["/usr/local/nvm/nvm.sh;", "nvm install;", "npm", "install", "--global", "serve;", 'serve']