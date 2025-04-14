FROM registry.access.redhat.com/ubi9/ubi:latest AS base


ARG USER_ID=1001
ARG GROUP_ID=1001
ENV USER_NAME=default

ENV HOME="/home/${USER_NAME}"
ENV PATH="${HOME}/.local/bin:${PATH}"
ENV APP="/app"

ENV PYTHONUNBUFFERED=1

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
    # Install git, nano, python 
    dnf install git nano python3 -y; \
    # clear cache
    dnf clean all


# Create user and set permissions
RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -u ${USER_ID} -r -g ${USER_NAME} -d ${HOME} -s /bin/bash ${USER_NAME} 

WORKDIR ${HOME}

# install poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

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
WORKDIR ${APP}
## REPLACE: replace this COPY statement with project specific files/folders
COPY . . 

# Check App permissions
RUN chown -R ${USER_NAME}:${USER_NAME} ${APP} && \
    chmod -R 0750 ${APP}

# Run App as User
USER ${USER_NAME}

## Install project requirements, build project
RUN poetry python install $(cat .python-version); \
    poetry install

## Expose port and run app
EXPOSE 8080

#for uvicorn (FastAPI)
CMD [ "sh", "-c", "poetry run fastapi run src/**/main.py --port 8080 --workers 4 --host 0.0.0.0" ]

# for gunicorn (eg. Flask)
# CMD [ "sh", "-c", "GUNICORN_CMD_ARGS='--bind=0.0.0.0:8080 --workers=8' poetry run --frozen gunicorn 'src/python_template/main.py'" ]