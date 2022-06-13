FROM python:3.10-slim-buster

WORKDIR /bundler
COPY bundler.py .
COPY requirements.txt .

RUN apt-get update && apt-get install -y --no-install-recommends git gcc libc-dev && \
    python3 -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt

WORKDIR /bundler/rules
RUN git clone https://github.com/returntocorp/semgrep-rules.git .

WORKDIR /bundler
ENTRYPOINT ["python3", "bundler.py"]
