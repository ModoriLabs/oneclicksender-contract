import { DeployFunction } from "hardhat-deploy/dist/types"

const deployFn: DeployFunction = async function (hre) {
  const { deployments, getNamedAccounts } = hre
  const { deploy } = deployments
  const { deployer} = await getNamedAccounts()
  console.log("deployer: ", deployer);

  await deploy("BasicCostPolicy", {
    from: deployer,
    log: true,
    args: [deployer, 0, 0],
  })
}

deployFn.tags = ["local", "testnet", "mainnet", "BasicCostPolicy"]

export default deployFn
