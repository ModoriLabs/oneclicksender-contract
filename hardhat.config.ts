import * as dotenv from "dotenv"
import "@nomicfoundation/hardhat-foundry";
import "@nomicfoundation/hardhat-toolbox"
import "hardhat-deploy"
import "./tasks";

dotenv.config()
const TESTNET_MNEMONIC = process.env.TESTNET_MNEMONIC
const TESTNET_PRIVATE_KEY = process.env.TESTNET_PRIVATE_KEY
const API_KEY_ALCHEMY = process.env.API_KEY_ALCHEMY
const MAINNET_PRIVATE_KEY = process.env.MAINNET_PRIVATE_KEY
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY
const BSCSCAN_API_KEY = process.env.BSCSCAN_API_KEY
const SCS_API_KEY = process.env.SCS_API_KEY

const getTestnetAccounts = () => {
  if (TESTNET_PRIVATE_KEY !== undefined) {
    return [TESTNET_PRIVATE_KEY]
  } else {
    return []
  }
}

const getMainnetAccounts = () => (
  MAINNET_PRIVATE_KEY !== undefined ? [MAINNET_PRIVATE_KEY] : []
)

const config = {
  solidity: {
    version: "0.8.23",
    settings: {
      optimizer: {
        enabled: true,
        runs: 10000000,
      },
    },
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
    feeRecipient: {
      default: "0x509477dc6AB2EE4eE42765A90420DA2c2CF2d165",
    }
  },
  networks: {
    localhost: {
      url: "http://localhost:8545",
      accounts: getTestnetAccounts(),
    },
    mainnet: {
      url: `https://eth-mainnet.g.alchemy.com/v2/${API_KEY_ALCHEMY}`,
      chainId: 1,
      accounts: getMainnetAccounts(),
    },
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${API_KEY_ALCHEMY}`,
      chainId: 11155111,
      accounts: getTestnetAccounts(),
    },
    soneium: {
      url: `https://soneium.rpc.scs.startale.com?apikey=${SCS_API_KEY}`,
      chainId: 1868,
      accounts: getMainnetAccounts(),
    },
    polygon: {
      url: `https://polygon-mainnet.g.alchemy.com/v2/${API_KEY_ALCHEMY}`,
      chainId: 137,
      accounts: getMainnetAccounts(),
      gasPrice: 280000000000, // 280 gwei
    },
    mumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/${API_KEY_ALCHEMY}`,
      chainId: 80001,
      accounts: getTestnetAccounts(),
      gasPrice: 2500000000,
    },
    bsc: {
      url: 'https://bsc-dataseed.binance.org',
      chainId: 56,
      accounts: getMainnetAccounts(),
      gasPrice: 3000000000,
    },
    bsc_testnet: {
      url: "https://data-seed-prebsc-1-s2.binance.org:8545",
      chainId: 97,
      accounts: getTestnetAccounts(),
      gasPrice: 5000000000,
    },
    // klaytn
    baobab: {
      url: "https://public-en-baobab.klaytn.net",
      chainId: 1001,
      accounts: getTestnetAccounts(),
    },
    cypress: {
      url: "https://public-en-cypress.klaytn.net",
      chainId: 8217,
      accounts: MAINNET_PRIVATE_KEY !== undefined ? [MAINNET_PRIVATE_KEY] : [],
    },
  },
  etherscan: {
    apiKey: {
      sepolia: ETHERSCAN_API_KEY,
      bscTestnet: BSCSCAN_API_KEY,
    },
  }
};

export default config
