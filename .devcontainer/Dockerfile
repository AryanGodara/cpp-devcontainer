FROM mcr.microsoft.com/devcontainers/cpp:1-debian-12

RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        clangd \
        clang-format \
        clang-tidy \
        ninja-build \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
