# Avalanche Testnet

Mostly from following this guide: https://docs.avax.network/build/tutorials/platform/create-a-local-test-network


## Private Keys

See: [genesis/genesis_local.go](https://github.com/ava-labs/avalanchego/blob/91599fea5fd30e060bec9e2d650e4f9b01f9bca5/genesis/genesis_local.go#L12-L14)

### P-Chain
```
Key: PrivateKey-vmRQiZeXEXYMyJhEiqdC2z5JhuDbxL8ix9UVvjgMu2Er1NepE
Address: P-local1g65uqn6t77p656w64023nh8nd9updzmxyymev2
```

### X-Chain
```
Key: PrivateKey-ewoqjP7PxY4yr3iLTpLisriqt94hdyDFNgchSxGGztUrTXtNN
Address: X-local18jma8ppw3nhx5r4ap8clazz0dps7rv5u00z96u
```

### C-Chain
```
Key: 56289e99c94b6912bfc12adc093c9b51124f0dc54ac7a766b2bc5ccf558d8027
Address: 0x8db97C7cEcE249c2b98bDC0226Cc4C2A57BF52FC
```


## Issue: `no preimage found for hash`

In order to recreate the `no preimage found for hash` simply

1. `docker-compose up` - this starts a 5 node localnet and generates C-Chain traffic.

2. Wait a few moments for everything to boostrap

3. `./curls/debug_getModifiedAccountsByNumber.sh`

The response of the curl will look like
```json
{
    "jsonrpc": "2.0",
    "id": 1,
    "error": {
        "code": -32000,
        "message": "no preimage found for hash 5a9331cb1d584bc0703e5252f4fccf19b3887d5a12e7edad074d585640a7ff57"
    }
}
```