FROM registry.access.redhat.com/ubi9/ubi:latest AS base

ARG USER_ID=1001
ARG GROUP_ID=1001
ENV USER_NAME=default

ENV HOME="/home/${USER_NAME}"
ENV PATH="${HOME}/.local/bin:${PATH}"
# Production App will be stored in /app
ENV APP="/app"

ENV PYTHONUNBUFFERED=1

USER root

# Check for package update
RUN dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
    # Install git, nano
    dnf install git nano  -y; \
    # clear cache
    dnf clean all

# Create user and set permissions
RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -u ${USER_ID} -r -g ${USER_NAME} -m -d ${HOME} -s /bin/bash ${USER_NAME} 


# Install uv, latest python and ruff 
RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="$HOME/.local/bin" sh
RUN uv tool install ruff@latest

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
RUN uv venv && \
    source .venv/bin/activate && \
    uv pip install .

## Expose port and run app
EXPOSE 8080

#for uvicorn (FastAPI)
CMD [ "sh", "-c", "uv run fastapi run src/**/main.py --port 8080 --workers 4 --host 0.0.0.0" ]

# for gunicorn (eg. Flask)
# CMD ["sh", "-c", "uv run --frozen gunicorn --bind=0.0.0.0:8080 --workers=8 src/**/main:app"]