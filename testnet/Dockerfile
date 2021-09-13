FROM phusion/baseimage:focal-1.0.0

RUN apt-get update \
    && apt-get -y install curl gcc g++ git jq lsof paxctl sudo tmux wget \
    && rm -rf /var/lib/apt/lists/*

# Install golang
ARG GO_VERSION=1.15.14
RUN wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -xvf go${GO_VERSION}.linux-amd64.tar.gz && \
    mv go /usr/local && \
    rm go${GO_VERSION}.linux-amd64.tar.gz
ENV GOROOT  /usr/local/go
ENV GOPATH /root/.go
ENV PATH=$PATH:$GOPATH/bin:$GOROOT/bin

WORKDIR /home/avalanche

ENV TAG v1.5.3
RUN git clone https://github.com/ava-labs/avalanchego.git && \
    cd avalanchego && \
    git pull && \
    git fetch --tags && \
    git checkout $TAG


WORKDIR /home/avalanche/avalanchego
RUN ./scripts/build.sh && \
    ln -s /home/avalanche/avalanchego/build/avalanchego /usr/local/bin/

WORKDIR /home/avalanche
# COPY ./chain_config /home/avalanche/chain_config  # Not working for some reason
COPY ./chain_config /root/.avalanchego/configs/chains

RUN git clone https://github.com/ava-labs/avash.git && \
    cd avash && go build && \
    ln -s /home/avalanche/avash/avash /usr/local/bin/
RUN mkdir -p /home/avalanche/avash_data && \
    mkdir -p /home/avalanche/logs

COPY avash.yaml /root/.avash.yaml

COPY testnet.sh /home/avalanche/testnet.sh
COPY generate_c_chain_traffic.sh /home/avalanche/generate_c_chain_traffic.sh
