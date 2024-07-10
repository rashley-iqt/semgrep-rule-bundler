FROM python:3.10-slim-buster

ENV DEBIAN_FRONTEND "noninteractive"
ENV PYTHONUNBUFFERED 1
ENV PATH="${PATH}:/root/.local/bin"
COPY pyproject.toml pyproject.toml

WORKDIR /bundler
COPY bundler.py .
COPY pyproject.toml .

RUN apt-get update && apt-get install -y --no-install-recommends git gcc libc-dev curl && \
    python3 -m pip install --upgrade pip && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    poetry config virtualenvs.create false

RUN poetry install --no-root

WORKDIR /bundler/rules
RUN git clone https://github.com/returntocorp/semgrep-rules.git .

WORKDIR /bundler
ENTRYPOINT ["python3", "bundler.py"]
