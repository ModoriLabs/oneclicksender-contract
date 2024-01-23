import { DeployFunction } from "hardhat-deploy/dist/types"

type params ={
  [network: string]: {
    oneTimeFee?: bigint,
    perUserFee?: bigint
  }
}

const DECIMAL16 = 10n ** 16n

// perUserFee is not used but kept the same as oneTimeFee not to be used for free.
const params: params = {
  "mainnet": {
    oneTimeFee: DECIMAL16,
    perUserFee: DECIMAL16,
  },
  "bsc": {
    oneTimeFee: 8n * DECIMAL16,
    perUserFee: 8n * DECIMAL16,
  },
  "bscTestnet": {
    oneTimeFee: 8n * DECIMAL16,
    perUserFee: 8n * DECIMAL16,
  },
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
