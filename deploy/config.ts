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
  "bsc": {
    oneTimeFee: 8n * DECIMAL16, // 1 BNB = $300 => $24 = 0.08 BNB
    perUserFee: 8n * DECIMAL16,
  },
  "bscTestnet": {
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
  }
}
