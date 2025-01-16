import { DeployFunction } from "hardhat-deploy/dist/types"
import { MAX_FREE_USER_COUNT, params } from "./config";

const deployFn: DeployFunction = async function (hre) {
  const { deployments, getNamedAccounts } = hre
  const { deploy } = deployments
  const { deployer} = await getNamedAccounts()
  console.log("deployer: ", deployer);
  const oneTimeFee = params[hre.network.name].oneTimeFee!;
  const perUserFee = params[hre.network.name].perUserFee!;

  await deploy("WhitelistCostPolicy", {
    from: deployer,
    log: true,
    args: [deployer, oneTimeFee, perUserFee, MAX_FREE_USER_COUNT],
  })
}

deployFn.tags = ["local", "testnet", "mainnet", "WhitelistCostPolicy"]

export default deployFn
