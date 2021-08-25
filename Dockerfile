FROM --platform=amd64 ubuntu:20.04

# DO NOT RUN THIS CONTAINER INTERACTIVELY!  Run it
# daemonized (-d) and then exec into it specifying bash

# Setting DEBIAN_FRONTEND in ENV doesn't appear to work...
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update \
    && apt-get install --no-install-recommends \
    -y \
    net-tools \
    unzip \
    traceroute \
    dnsutils \
    netcat \
    curl \
    vim \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && curl \
    "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

RUN adduser --quiet --disabled-password --uid 1099 --shell /bin/bash tester

# We switch to our new user who can't install anything for security reasons
USER tester

# This allows our container to keep running indefinitely
ENTRYPOINT ["tail", "-f", "/dev/null"]
