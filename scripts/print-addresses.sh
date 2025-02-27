#!/usr/bin/env bash

# Usage: ./scripts/print-addresses.sh <network>
NETWORK=$1
if [ -z "$NETWORK" ]; then
  echo "Usage: ./scripts/print-addresses.sh <network>"
  exit 1
fi

if [ "$NETWORK" == "mainnet" ]; then
  EXPLORER="https://etherscan.io/address/"
elif [ "$NETWORK" == "sepolia" ]; then
  EXPLORER="https://sepolia.etherscan.io/address/"
elif [ "$NETWORK" == "soneium" ]; then
  EXPLORER="https://soneium.blockscout.com/address/"
elif [ "$NETWORK" == "polygon" ]; then
  EXPLORER="https://polygonscan.com/address/"
elif [ "$NETWORK" == "mumbai" ]; then
  EXPLORER="https://mumbai.polygonscan.com/address/"
elif [ "$NETWORK" == "baobab" ]; then
  EXPLORER="https://baobab.klaytnscope.com/account/"
elif [ "$NETWORK" == "cypress" ]; then
  EXPLORER="https://klaytnscope.com/account/"
elif [ "$NETWORK" == "bsc_testnet" ]; then
  EXPLORER="https://testnet.bscscan.com/address/"
elif [ "$NETWORK" == "bsc" ] || [ "$NETWORK" == "bsc_USTN2" ]; then
  EXPLORER="https://bscscan.com/address/"
elif [ "$NETWORK" == "opBnb" ]; then
  EXPLORER="https://opbnb.bscscan.com/address/"
elif [ "$NETWORK" == "opBnbTestnet" ]; then
  EXPLORER="https://opbnb-testnet.bscscan.com/address/"
elif [ "$NETWORK" == "localhost" ]; then
  EXPLORER=""
else
  echo "Invalid network: $NETWORK"
fi

bun hardhat export --network $NETWORK --export temp.json
echo '| Contracts                    | Address                                                                                                                  |'
echo '|------------------------------|--------------------------------------------------------------------------------------------------------------------------|'
jq -r ".contracts | to_entries[] | [.key, \"[\(.value.address)]($EXPLORER\(.value.address))\"] | @tsv" temp.json \
  | sed 's/\t/ | /g; s/^/| /; s/$/ |/' \
  | awk '!(/Implementation/ || /Proxy/)'

rm temp.json
