import { DeployFunction } from "hardhat-deploy/dist/types"

const deployFn: DeployFunction = async function (hre) {
  const { deployments, getNamedAccounts } = hre
  const { deploy } = deployments
  const { deployer} = await getNamedAccounts()
  console.log("deployer: ", deployer);
  const oneTimeFee = hre.ethers.utils.parseEther("0.001")
  const perUserFee = oneTimeFee;
  const maxFreeUserCount = 10;

  await deploy("BasicCostPolicy", {
    from: deployer,
    log: true,
    args: [deployer, oneTimeFee, perUserFee, maxFreeUserCount],
  })
}

deployFn.tags = ["local", "testnet", "mainnet", "BasicCostPolicy"]

export default deployFn
