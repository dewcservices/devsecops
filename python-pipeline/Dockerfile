FROM registry.access.redhat.com/ubi9/ubi:latest AS base

ARG USER_ID=1001
ARG GROUP_ID=1001
ENV USER_NAME=default

ENV HOME="/app"
ENV PATH="/app/.local/bin:${PATH}"

ENV PYTHONUNBUFFERED=1

USER root

# Get version from file 
COPY .python-version .python-version

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
    # Install git, nano & Python
    dnf install git nano python$(cat .python-version) python$(cat .python-version)-pip -y; \
    # clear cache
    dnf clean all

# Symlink pip(VERSION) to pip3
RUN ln -s /usr/bin/pip$(cat .python-version) /usr/bin/pip3

WORKDIR ${HOME}

# Create user and set permissions
RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -u ${USER_ID} -r -g ${USER_NAME} -d ${HOME} -s /bin/bash ${USER_NAME} 

#-----------------------------

# Dev target
FROM base AS dev
COPY .devcontainer/devtools.sh /tmp/devtools.sh
# Install extra dev tools as root, then run as default user
RUN chmod +x /tmp/devtools.sh && /tmp/devtools.sh  
USER ${USER_NAME}

# DEPLOYMENT EXAMPLE:
#-----------------------------

# Prod target
FROM base

## Move to app folder, copy project into container
WORKDIR ${HOME}
## REPLACE: replace this COPY statement with project specific files/folders
COPY . . 

# Check home
RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME} && \
    chmod -R 0750 ${HOME}

USER ${USER_NAME}

## Install project requirements, build project
RUN pip3 install .[test,dev]

## Expose port and run app
EXPOSE 8080

#for uvicorn (FastAPI)
CMD [ "sh", "-c", "fastapi run src/**/main.py --port 8080 --workers 4 --host 0.0.0.0" ]

# for gunicorn (eg. Flask)
# CMD [ "sh", "-c", "GUNICORN_CMD_ARGS='--bind=0.0.0.0:8080 --workers=8' gunicorn 'src/python_template/main.py'" ]