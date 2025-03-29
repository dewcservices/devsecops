FROM registry.access.redhat.com/ubi9/ubi:latest

ARG dev=false
ENV container oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano, gcc, gcc++
dnf install git nano gcc gcc-c++ -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
dnf clean all

# Install rustup and rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . $HOME/.cargo/env && rustup default stable


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
# RUN cargo build --release

## Expose port and run app
# EXPOSE 8080
# CMD [ "/app/cargo", "run" ]