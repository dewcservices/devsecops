FROM registry.access.redhat.com/ubi9/ubi:latest

RUN dnf update -y; \
# Install git, nano
dnf install git nano  -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
rm -rf /var/cache

# Install uv and latest python 
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN source $HOME/.local/bin/env && uv python install
ENV PYTHONUNBUFFERED 1

# OPTIONAL DEPLOYMENT EXAMPLE:
#-----------------------------
## Make App folder, copy project into container
# WORKDIR /app
# COPY . .

## Install project requirements, build project
# RUN uv pip install .  

## Expose port and run app
# EXPOSE 8080
# ENTRYPOINT [ "uv", "run", "--frozen", "gunicorn", "projectName" ]
