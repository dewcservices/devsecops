FROM registry.access.redhat.com/ubi9/ubi:latest

ARG dev=false
ENV container oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano, python 
dnf install git nano python3 -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
dnf clean all

# install poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PYTHONUNBUFFERED=1

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
# RUN poetry python install $(cat .python-version)
# RUN poetry install

## Expose port and run app
# EXPOSE 8080
# ENTRYPOINT [ "poetry", "run", "fastapi", "run", "src/python_template/main.py", "--port", "8080", "--workers", "4" "--host", "0.0.0.0"]

# for gunicorn (Flask)
# CMD [ "GUNICORN_CMD_ARGS='--bind=0.0.0.0:8080 --workers=8'", "poetry", "run", "--frozen", "gunicorn", "'src/python_template/main.py'" ]
