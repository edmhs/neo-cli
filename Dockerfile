# NEO private network - Dockerfile
FROM ubuntu:16.04

LABEL maintainer="AndIT"
LABEL authors="Eduards M"

ENV DEBIAN_FRONTEND noninteractive

# Disable dotnet usage information collection
# https://docs.microsoft.com/en-us/dotnet/core/tools/telemetry#behavior
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1


# Install system dependencies. always should be done in one line
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run
RUN apt-get update && apt-get install -y \
    unzip \
    screen \
    expect \
    libleveldb-dev \
    git-core \
    wget \
    curl \
    libssl-dev \
    apt-transport-https
    
    
#RUN apt-get update && apt-get install -y apt-transport-https

# Setup microsoft repositories
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
RUN apt-get update
RUN apt-get install -y dotnet-sdk-2.1.4



# APT cleanup to reduce image size
RUN rm -rf /var/lib/apt/lists/*


# neo setup: clone and install dependencies
RUN git clone https://github.com/neo-project/neo-cli.git /neo-cli-src

WORKDIR /neo-cli-src
RUN dotnet restore
RUN dotnet publish -c Release -o /neo-cli

# Copy plugins manually for now
COPY ./Plugins /neo-cli/Plugins

# Create plugins directory
# RUN mkdir -p /neo-cli/Plugins

# Plugin setup build from source
# RUN git clone https://github.com/neo-project/neo-plugins.git /neo-plugins

# RUN rm -rf /neo-plugins/SimplePolicy.UnitTests

# SimplePolicy plugin build
# WORKDIR /neo-plugins
# RUN dotnet restore
# RUN dotnet publish -c Release -o /neo-cli/Plugins


WORKDIR /neo-cli


# Copy config files
# COPY ./config/config.json /neo-cli/config.json
# COPY ./config/protocol.json /neo-cli/protocol.json

# Copy wallet 
# COPY ./config/wallet.json /neo-cli/wallet.json

# Copy scripts
COPY ./scripts/entrypoint.sh /neo-cli
COPY ./scripts/cli.sh /neo-cli

# Change scripts permissions
RUN chmod +x /neo-cli/entrypoint.sh
RUN chmod +x /neo-cli/cli.sh

# Run entrypoint script
ENTRYPOINT ["/neo-cli/entrypoint.sh" ]


