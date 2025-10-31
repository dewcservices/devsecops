FROM registry.access.redhat.com/ubi9/ubi:latest AS base

ARG USER_ID=1001
ARG GROUP_ID=1001
ENV USER_NAME=default

ENV HOME="/home/${USER_NAME}"
ENV PATH="${HOME}/.local/bin:${PATH}"
ENV APP="/app"

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano, nodejs and npm
dnf module enable nodejs:22 -y && \
dnf install git nano nodejs npm vim -y; \
# clear cache
dnf clean all

# Create user and set permissions
RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -u ${USER_ID} -r -g ${USER_NAME} -m -d ${HOME} -s /bin/bash ${USER_NAME} 

#-----------------------------

# Dev target
FROM base AS dev
COPY .devcontainer/devtools.sh /tmp/devtools.sh
# Install extra dev tools as root, then run as default user
RUN chmod +x /tmp/devtools.sh && /tmp/devtools.sh
# Open dev port
EXPOSE 8000
USER ${USER_NAME}
WORKDIR ${APP}

# DEPLOYMENT EXAMPLE:
#-----------------------------

# Prod target
FROM base

## Move to app folder, copy project into container
WORKDIR ${APP}
## REPLACE: replace this COPY statement with project specific files/folders
COPY --chown=${USER_NAME}:${USER_NAME} . .

# Run App as User
USER ${USER_NAME}

## Install project requirements, build project
RUN npm install lite-server --save-dev; \
npm run build --prod

## Expose port and run app
EXPOSE 8080

CMD [ "lite-server --baseDir='dist/*/'"  ]

# EXPOSE 3000
#CMD ["/usr/local/nvm/nvm.sh;", "nvm install;", "npm", "install", "--global", "serve;", 'serve']