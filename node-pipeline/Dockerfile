FROM registry.access.redhat.com/ubi9/ubi:latest


ENV container=oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git & nano 
dnf install git nano -y; \
# clear cache
dnf clean all

# Install nvm
WORKDIR /root
ADD https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh /root/
RUN chmod +x /root/install.sh && /root/install.sh
RUN export NVM_DIR="$HOME/.nvm"; \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; \ 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
nvm install 23

# Dev target
FROM base AS dev
COPY .devcontainer/devtools.sh /tmp/devtools.sh
RUN  /tmp/devtools.sh
USER default

# DEPLOYMENT EXAMPLE:
#-----------------------------

# Prod target
FROM base
USER default

## Make App folder, copy project into container
WORKDIR /app
## REPLACE: replace this COPY statement with project specific files/folders
COPY . . 

## Install project requirements, build project
RUN npm install lite-server --save-dev \
npm build --prod

## Expose port and run app
EXPOSE 8080
CMD [ "lite-server --baseDir='dist/*/'"  ]