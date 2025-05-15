type params ={
  [network: string]: {
    oneTimeFee?: bigint,
    perUserFee?: bigint
  }
}

export const DECIMAL16 = 10n ** 16n
export const DECIMAL18 = 10n ** 18n
export const MAX_FREE_USER_COUNT = 10;

// perUserFee is not used but kept the same as oneTimeFee not to be used for free.
export const params: params = {
  "localhost": { // eth l2 test
    oneTimeFee: DECIMAL16, // 1 ETH = $2266 => $22.66 = 0.01 ETH
    perUserFee: DECIMAL16,
  },
  "mainnet": {
    oneTimeFee: DECIMAL16, // 1 ETH = $2266 => $22.66 = 0.01 ETH
    perUserFee: DECIMAL16,
  },
  "soneium": {
    oneTimeFee: DECIMAL16, // 1 ETH = $2266 => $22.66 = 0.01 ETH
    perUserFee: DECIMAL16,
  },
  "bsc": {
    oneTimeFee: 8n * DECIMAL16, // 1 BNB = $300 => $24 = 0.08 BNB
    perUserFee: 8n * DECIMAL16,
  },
  "bsc_testnet": {
    oneTimeFee: 8n * DECIMAL16,
    perUserFee: 8n * DECIMAL16,
  },
  "baobab": {
    oneTimeFee: 120n * DECIMAL18,
    perUserFee: 120n * DECIMAL18,
  },
  "cypress": {
    oneTimeFee: 120n * DECIMAL18, // 1 KLAY = $0.2 (2024.01.29) => $24 = 120 KLAY
    perUserFee: 120n * DECIMAL18,
  },
  "mumbai": {
    oneTimeFee: DECIMAL18 / 1000n, // 0.001 MATIC in tests
    perUserFee: DECIMAL18 / 1000n,
  },
  "polygon": {
    oneTimeFee: 30n * DECIMAL18,
    perUserFee: 30n * DECIMAL18,
  },
  "worldchain": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "base": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "optimism": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "unichain": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "ink": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "superseed": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "zora": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "shape": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "settlus": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "blast": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "linea": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "arbitrum": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "arbitrum_nova": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "scroll": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "berachain": {
    oneTimeFee: 6n * DECIMAL18,
    perUserFee: 6n * DECIMAL18,
  },
  "ronin": {
    oneTimeFee: 35n * DECIMAL18,
    perUserFee: 35n * DECIMAL18,
  },
  "gnosis": {
    oneTimeFee: 25n * DECIMAL18,
    perUserFee: 25n * DECIMAL18,
  },
  "apechain": {
    oneTimeFee: 35n * DECIMAL18,
    perUserFee: 35n * DECIMAL18,
  },
  "avalanche": {
    oneTimeFee: 1n * DECIMAL18,
    perUserFee: 1n * DECIMAL18,
  },
  "celo": {
    oneTimeFee: 50n * DECIMAL18,
    perUserFee: 50n * DECIMAL18,
  },
  "sonic": {
    oneTimeFee: 3900n * DECIMAL18,
    perUserFee: 3900n * DECIMAL18,
  },
  "opbnb": {
    oneTimeFee: 8n * DECIMAL16,
    perUserFee: 8n * DECIMAL16,
  }
}
