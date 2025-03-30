FROM registry.access.redhat.com/ubi9/ubi:latest AS base

ENV container=oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano & clang, cmake, gcc-c++, ninja-build, meson, gdb
dnf install git nano clang cmake gcc-c++ ninja-build meson gdb -y; \
# Clear cache
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
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -G "Ninja"; \
cmake --build build --config Release

## clarify permissions
RUN chown -R default:0 /app && \
    chmod -R g=u /app

## Expose port and run app
EXPOSE 8080
USER default
CMD [ "/app/out/build/cpp-template"  ]
