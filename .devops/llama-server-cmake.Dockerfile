FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN cmake -B build

RUN cmake --build build --config Release --target llama-server

ENTRYPOINT ["./build/bin/llama-server"]
