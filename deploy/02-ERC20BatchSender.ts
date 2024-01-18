import { DeployFunction } from "hardhat-deploy/dist/types"

const deployFn: DeployFunction = async function (hre) {
  const { deployments, getNamedAccounts } = hre
  const { deploy, get } = deployments
  const { deployer} = await getNamedAccounts()
  console.log("deployer: ", deployer);
  const basicCostPolicy = (await get("BasicCostPolicy")).address
  console.log("basicCostPolicy: ", basicCostPolicy);

  await deploy("ERC20BatchSender", {
    from: deployer,
    log: true,
    proxy: {
      proxyContract: 'UUPS',
      upgradeIndex: 0,
      upgradeFunction: {
        methodName: "upgradeToAndCall",
        upgradeArgs: ['{implementation}', '{data}']
      },
      execute: {
        init: {
          methodName: 'initialize',
          args: [
            deployer,
            basicCostPolicy,
          ],
        },
        /*
        onUpgrade: {
          methodName: 'reinitialize',
          args: [
            deployer,
            basicCostPolicy,
          ],
        }
         */
      }
    }
  })
}

deployFn.tags = ["local", "testnet", "mainnet"]

export default deployFn
