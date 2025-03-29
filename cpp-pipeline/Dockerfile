FROM registry.access.redhat.com/ubi9/ubi:latest AS base

ARG dev=false
ENV container oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano & clang, cmake, gcc-c++, ninja-build, meson, gdb
dnf install git nano clang cmake gcc-c++ ninja-build meson gdb -y; \
# Clear cache
dnf clean all

#----
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
# RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -G "Ninja"
# RUN cmake --build build --config Release

## Expose port and run app
# EXPOSE 8080
# CMD [ /app/out/build/cpp-template  ]
