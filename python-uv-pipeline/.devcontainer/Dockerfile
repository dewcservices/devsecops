FROM registry.access.redhat.com/ubi9/ubi:latest

# Install git, nano
RUN dnf install git nano  -y

# Install uv and latest python 
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN source $HOME/.local/bin/env && uv python install
ENV PYTHONUNBUFFERED 1

# Install nodejs for SonarQube 
RUN dnf install nodejs -y