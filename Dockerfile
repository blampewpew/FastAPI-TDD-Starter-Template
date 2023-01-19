# pull official base image
FROM python:3.10.8-slim-buster

# set working directory
WORKDIR /usr/src

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update \
  && apt-get -y install netcat gcc \
  && apt-get clean

# install python dependencies
RUN pip install --upgrade pip
RUN pip install "poetry==1.3.2"

COPY poetry.lock pyproject.toml /usr/src/

# Project initialization:
RUN poetry config virtualenvs.create false \
  # Added condition to add --dev when in production environment
  && poetry install --no-interaction --no-ansi --no-root

# add app
COPY . .