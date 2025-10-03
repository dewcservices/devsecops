FROM registry.access.redhat.com/ubi9/ubi:latest AS base

ARG USER_ID=1001
ARG GROUP_ID=1001
ENV USER_NAME=default

ENV HOME="/home/${USER_NAME}"
ENV PATH="${HOME}/.local/bin:${PATH}"
# Production App will be stored in /app
ENV APP="/app"

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano & clang, cmake, gcc-c++, ninja-build, meson, gdb
dnf install git nano clang cmake gcc-c++ ninja-build meson gdb -y; \
# Clear cache
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
USER ${USER_NAME}
WORKDIR ${HOME}

# DEPLOYMENT EXAMPLE:
#-----------------------------

# Prod target
FROM base

## Move to app folder, copy project into container
WORKDIR ${APP}
## REPLACE: replace this COPY statement with project specific files/folders
COPY . . 

# Check App permissions
RUN chown -R ${USER_NAME}:${USER_NAME} ${APP} && \
    chmod -R 0750 ${APP}

# Run App as User
USER ${USER_NAME}

## Install project requirements, build project
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -G "Ninja"; \
cmake --build build --config Release

## Expose port and run app
EXPOSE 8080
CMD [ "/app/out/build/cpp-template"  ]
