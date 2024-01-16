import * as dotenv from "dotenv"
import "@nomicfoundation/hardhat-foundry";
import "@nomicfoundation/hardhat-toolbox"
import "hardhat-deploy"

dotenv.config()
const TESTNET_MNEMONIC = process.env.TESTNET_MNEMONIC
const TESTNET_PRIVATE_KEY = process.env.TESTNET_PRIVATE_KEY
const API_KEY_ALCHEMY = process.env.API_KEY_ALCHEMY
const MAINNET_PRIVATE_KEY = process.env.MAINNET_PRIVATE_KEY
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY

const getAccounts = () => {
  if (TESTNET_PRIVATE_KEY !== undefined) {
    return [TESTNET_PRIVATE_KEY]
  } else {
    return []
  }
}

const config = {
  solidity: {
    version: "0.8.23",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
  namedAccounts: {
    deployer: {
      default: 0,
    }
  },
  networks: {
    mainnet: {
      url: `https://eth-mainnet.g.alchemy.com/v2/${API_KEY_ALCHEMY}`,
      chainId: 1,
      accounts: getAccounts(),
    },
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${API_KEY_ALCHEMY}`,
      chainId: 11155111,
      accounts: getAccounts(),
    },
  },
  etherscan: {
    apiKey: {
      sepolia: ETHERSCAN_API_KEY,
    },
  },
};

export default config
