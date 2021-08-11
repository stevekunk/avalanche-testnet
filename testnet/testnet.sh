#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

BASE=/home/avalanche
AVALANCHE_DIR=/home/avalanche/avalanchego

# NOTE: --chain-config-dir=/home/avalanche/chain_config \
#   is not working. Instead, just place the config in
#   /root/.avalanchego/configs/chains/C/config.json

# Node 1
avalanchego \
    --http-host=0.0.0.0 \
    --public-ip=127.0.0.1 \
    --snow-sample-size=2 \
    --snow-quorum-size=2 \
    --http-port=9650 \
    --staking-port=9651 \
    --db-dir=${BASE}/db/node1 \
    --staking-enabled=true \
    --network-id=local \
    --bootstrap-ips= \
    --staking-tls-cert-file=${AVALANCHE_DIR}/staking/local/staker1.crt \
    --staking-tls-key-file=${AVALANCHE_DIR}/staking/local/staker1.key &

# Node 2
avalanchego \
    --http-host=0.0.0.0 \
    --public-ip=127.0.0.1 \
    --snow-sample-size=2 \
    --snow-quorum-size=2 \
    --http-port=9652 \
    --staking-port=9653 \
    --db-dir=${BASE}/db/node2 \
    --staking-enabled=true \
    --network-id=local \
    --bootstrap-ips=127.0.0.1:9651 \
    --bootstrap-ids=NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg \
    --staking-tls-cert-file=${AVALANCHE_DIR}/staking/local/staker2.crt \
    --staking-tls-key-file=${AVALANCHE_DIR}/staking/local/staker2.key &

# Node 3
avalanchego \
    --http-host=0.0.0.0 \
    --public-ip=127.0.0.1 \
    --snow-sample-size=2 \
    --snow-quorum-size=2 \
    --http-port=9654 \
    --staking-port=9655 \
    --db-dir=${BASE}/db/node3 \
    --staking-enabled=true \
    --network-id=local \
    --bootstrap-ips=127.0.0.1:9651 \
    --bootstrap-ids=NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg \
    --staking-tls-cert-file=${AVALANCHE_DIR}/staking/local/staker3.crt \
    --staking-tls-key-file=${AVALANCHE_DIR}/staking/local/staker3.key &

# Node 4
avalanchego \
    --http-host=0.0.0.0 \
    --public-ip=127.0.0.1 \
    --snow-sample-size=2 \
    --snow-quorum-size=2 \
    --http-port=9656 \
    --staking-port=9657 \
    --db-dir=${BASE}/db/node4 \
    --staking-enabled=true \
    --network-id=local \
    --bootstrap-ips=127.0.0.1:9651 \
    --bootstrap-ids=NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg \
    --staking-tls-cert-file=${AVALANCHE_DIR}/staking/local/staker4.crt \
    --staking-tls-key-file=${AVALANCHE_DIR}/staking/local/staker4.key &

# Node 5
avalanchego \
    --http-host=0.0.0.0 \
    --public-ip=127.0.0.1 \
    --snow-sample-size=2 \
    --snow-quorum-size=2 \
    --http-port=9658 \
    --staking-port=9659 \
    --db-dir=${BASE}/db/node5 \
    --staking-enabled=true \
    --network-id=local \
    --bootstrap-ips=127.0.0.1:9651 \
    --bootstrap-ids=NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg \
    --staking-tls-cert-file=${AVALANCHE_DIR}/staking/local/staker5.crt \
    --staking-tls-key-file=${AVALANCHE_DIR}/staking/local/staker5.key &

./generate_c_chain_traffic.sh
