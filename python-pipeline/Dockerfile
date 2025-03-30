FROM registry.access.redhat.com/ubi9/ubi:latest AS base

COPY .python-version .python-version


ENV container=oci
ENV USER=default

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install git, nano & Python
dnf install git nano python$(cat .python-version) python$(cat .python-version)-pip -y; \
# clear cache
dnf clean all

# Symlink pip(VERSION) to pip3
RUN ln -s /usr/bin/pip$(cat .python-version) /usr/bin/pip3

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
RUN pip3 install --include-deps .[test,dev]

## clarify permissions
RUN chown -R default:0 /app && \
    chmod -R g=u /app

## Expose port and run app
EXPOSE 8080

USER default

# for uvicorn (FastAPI)
CMD [ "fastapi", "run", "src/**/main.py", "--port", "8080", "--workers", "4" "--host", "0.0.0.0" ]

# for gunicorn (eg. Flask)
# CMD [ "GUNICORN_CMD_ARGS='--bind=0.0.0.0:8080 --workers=8'","--frozen", "gunicorn", "'src/python_template/main.py'" ]
