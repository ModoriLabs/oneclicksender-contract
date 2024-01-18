import { DeployFunction } from "hardhat-deploy/dist/types"

const deployFn: DeployFunction = async function (hre) {
  const { deployments, getNamedAccounts } = hre
  const { deploy } = deployments
  const { deployer} = await getNamedAccounts()
  console.log("deployer: ", deployer);

  await deploy("MockERC20", {
    from: deployer,
    log: true,
    args: ["TEST_ERC20", "TEST", 18],
  })
}

deployFn.tags = ["MockERC20"]

export default deployFn
