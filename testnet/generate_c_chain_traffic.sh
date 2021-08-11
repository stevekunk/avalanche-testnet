#!/usr/bin/env bash

# Generate Traffice on the C-Chain in order to advance the block height.
# Create a transactions roughly every 5 seconds

wait_for_node() {
  test_node() {
    response=$(
        curl -s --location --request POST 'http://localhost:9650/ext/bc/C/rpc' \
             --header 'Content-Type: application/json' \
             --data-raw '{
                 "jsonrpc": "2.0",
                 "method": "eth_blockNumber",
                 "params": [],
                 "id": 1
             }'
    )
    curl_status=$?
    result=$(echo "$response" | jq ".result")
    if [[ ! "${curl_status}" -eq 0 || -z "${response}" || "${result}" = "null" || -z "${result}" ]]
    then
      return 1
    fi
    return 0
  }

  echo "Waiting for node availability..."
  while ! test_node
  do
    echo "Waiting for node to come online..."
    sleep 2
  done
}

#########
# START #
#########

wait_for_node

# Set up account
curl -s --location --request POST 'http://localhost:9650/ext/bc/C/rpc' \
--header 'Content-Type: application/json' \
--data-raw '{
    "jsonrpc": "2.0",
    "method": "personal_importRawKey",
    "params": [
        "56289e99c94b6912bfc12adc093c9b51124f0dc54ac7a766b2bc5ccf558d8027",
        null
    ],
    "id": 1
}' | jq

# Unlock Account
curl -s --location --request POST 'http://localhost:9650/ext/bc/C/rpc' \
--header 'Content-Type: application/json' \
--data-raw '{
    "jsonrpc": "2.0",
    "method": "personal_unlockAccount",
    "params": [
        "0x8db97c7cece249c2b98bdc0226cc4c2a57bf52fc",
        null,
        0
    ],
    "id": 1
}' | jq

while :
do
    echo "Sending C-Chain transaction"
    curl -s --location --request POST 'http://localhost:9650/ext/bc/C/rpc' \
        --header 'Content-Type: application/json' \
        --data-raw '{
            "jsonrpc": "2.0",
            "method": "eth_sendTransaction",
            "params": [{
                "from": "0x8db97C7cEcE249c2b98bDC0226Cc4C2A57BF52FC",
                "to": "0x8db97C7cEcE249c2b98bDC0226Cc4C2A57BF52FC",
                "gas": "0x76c0",
                "gasPrice": "0x9184e72a000",
                "value": "0x0"
            }],
            "id": 1
        }' | jq
    sleep 5
done
