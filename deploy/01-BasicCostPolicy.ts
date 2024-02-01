import { DeployFunction } from "hardhat-deploy/dist/types"

type params ={
  [network: string]: {
    oneTimeFee?: bigint,
    perUserFee?: bigint
  }
}

const DECIMAL16 = 10n ** 16n
const DECIMAL18 = 10n ** 18n

// perUserFee is not used but kept the same as oneTimeFee not to be used for free.
const params: params = {
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

const deployFn: DeployFunction = async function (hre) {
  const { deployments, getNamedAccounts } = hre
  const { deploy } = deployments
  const { deployer} = await getNamedAccounts()
  console.log("deployer: ", deployer);
  const oneTimeFee = params[hre.network.name].oneTimeFee;
  const perUserFee = params[hre.network.name].perUserFee;
  const maxFreeUserCount = 10;

  await deploy("BasicCostPolicy", {
    from: deployer,
    log: true,
    args: [deployer, oneTimeFee, perUserFee, maxFreeUserCount],
  })
}

deployFn.tags = ["local", "testnet", "mainnet", "BasicCostPolicy"]

export default deployFn
