# syntax=docker/dockerfile:1.4
FROM debian:bookworm-slim

# Install minimal, verified reverse-engineering runtime utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jre-headless \
    nodejs \
    npm \
    binutils \
    file \
    python3 \
    curl \
    iproute2 \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Create unprivileged analysis user with static UID/GID 1001
RUN groupadd -g 1001 analyst && \
    useradd -u 1001 -g analyst -m -s /bin/bash analyst && \
    mkdir -p /workspace && \
    chown -R analyst:analyst /workspace

USER analyst
WORKDIR /workspace

ENV HOME=/workspace
ENV NODE_ENV=production
ENV REA_SANDBOX=1

# Default entrypoint starts interactive contained shell
ENTRYPOINT ["/bin/bash"]
