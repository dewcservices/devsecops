# Good explaination of multi stage builds with poetry:
# https://medium.com/@albertazzir/blazing-fast-python-docker-builds-with-poetry-a78a66f5aed0

ARG VARIANT=3.12-bookworm
FROM python:${VARIANT} AS builder

ARG POETRY_VERSION=1.8.3
RUN pip install poetry==${POETRY_VERSION}

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

WORKDIR /app

# install dependencies before copying code to maximize docker cache capabilities
COPY pyproject.toml poetry.lock README.md ./

RUN --mount=type=cache,target=$POETRY_CACHE_DIR poetry install --without dev --no-root

FROM cgr.dev/chainguard/python:latest AS runtime

ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

# REPLACE: project names here
COPY example_project example_project

# REPLACE: run command here
ENTRYPOINT ["python", "-m", "wallet.main"]