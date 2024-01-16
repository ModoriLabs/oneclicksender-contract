import { DeployFunction } from "hardhat-deploy/dist/types"

const deployFn: DeployFunction = async function (hre) {
  const { deployments, getNamedAccounts } = hre
  const { deploy } = deployments
  const { deployer} = await getNamedAccounts()
  console.log("deployer: ", deployer);

  await deploy("ERC20BatchSender", {
    from: deployer,
    log: true,
    proxy: {
      proxyContract: 'UUPS',
      upgradeIndex: 0,
      execute: {
        init: {
          methodName: 'initialize',
          args: [
            deployer
          ],
        },
      }
    }
  })
}

deployFn.tags = ["local", "testnet", "mainnet"]

export default deployFn
