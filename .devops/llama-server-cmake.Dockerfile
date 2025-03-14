FROM ubuntu:22.04

# Install numactl along with existing dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    numactl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN cmake -B build

RUN cmake --build build --config Release --target llama-server

# Update ENTRYPOINT to use numactl --interleave=all
ENTRYPOINT ["numactl", "--interleave=all", "./build/bin/llama-server"]
