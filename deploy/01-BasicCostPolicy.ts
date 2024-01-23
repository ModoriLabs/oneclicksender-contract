import { DeployFunction } from "hardhat-deploy/dist/types"

type params ={
  [network: string]: {
    oneTimeFee?: number,
    perUserFee?: number
  }
}

// perUserFee is not used but kept the same as oneTimeFee not to be used for free.
const params: params = {
  "mainnet": {
    oneTimeFee: 1e16,
    perUserFee: 1e16
  },
  "bsc": {
    oneTimeFee: 8e16,
    perUserFee: 8e16
  },
  "bscTestnet": {
    oneTimeFee: 8e16,
    perUserFee: 8e16
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
