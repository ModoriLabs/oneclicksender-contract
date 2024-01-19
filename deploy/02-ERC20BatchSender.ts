import { DeployFunction } from "hardhat-deploy/dist/types"

const deployFn: DeployFunction = async function (hre) {
  const { deployments, getNamedAccounts } = hre
  const { deploy, get } = deployments
  const { deployer, feeRecipient} = await getNamedAccounts()
  console.log(`deployer: ${deployer}, feeRecipient: ${feeRecipient}`);
  const basicCostPolicy = (await get("BasicCostPolicy")).address
  console.log("basicCostPolicy: ", basicCostPolicy);

  await deploy("ERC20BatchSender", {
    from: deployer,
    log: true,
    proxy: {
      proxyContract: 'UUPS',
      upgradeIndex: 1,
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
            feeRecipient,
          ],
        },
        onUpgrade: {
          methodName: 'reinitialize',
          args: [
            basicCostPolicy,
            feeRecipient,
          ],
        }
      }
    }
  })
}

deployFn.tags = ["local", "testnet", "mainnet", "ERC20BatchSender"]

export default deployFn
