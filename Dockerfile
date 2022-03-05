# syntax=docker/dockerfile:1.2
# https://github.com/python-poetry/poetry/discussions/1879#discussioncomment-524408

FROM python:3.10-slim AS base

FROM base AS builder

ENV PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  POETRY_NO_INTERACTION=1 \
  POETRY_CACHE_DIR='/var/cache/pypoetry' \
  PATH="$PATH:/root/.local/bin" \
  POETRY_VERSION=1.1.13

# hadolint ignore=DL3042
RUN pip install "poetry==$POETRY_VERSION"

WORKDIR /src

COPY pyproject.toml poetry.lock /src/
RUN poetry export --without-hashes --no-interaction --no-ansi -f requirements.txt -o requirements.txt
# hadolint ignore=DL3042,DL3059
RUN pip install --prefix=/runtime --force-reinstall -r requirements.txt

COPY . /src

FROM base AS runtime
COPY --from=builder /runtime /usr/local
COPY . /app
WORKDIR /app

CMD ["python", "vidbot/__init__.py"]
