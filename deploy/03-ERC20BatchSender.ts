import { DeployFunction } from "hardhat-deploy/dist/types"
import { getChainId } from "hardhat";

const deployFn: DeployFunction = async function (hre) {
  const { deployments, getNamedAccounts } = hre
  const { deploy, get } = deployments
  const { deployer, feeRecipient} = await getNamedAccounts()
  console.log(`deployer: ${deployer}, feeRecipient: ${feeRecipient}`);
  const whitelistCostPolicy = (await get("WhitelistCostPolicy")).address
  console.log("whitelistCostPolicy: ", whitelistCostPolicy);

  const chainId = await getChainId()
  const getUpgradeIndex = () => {
    // In the deployment file, numDeployments: 2 equals upgradeIndex 1.
    // - mainnet, soneium: v1
    // - polygon, bsc, cypress: v2 (updated)
    // Testnet deployment version is not managed.
    if (chainId === "137" || chainId === "56" || chainId === "8217"){
      return 1
    } else {
      return 0
    }
  }

  await deploy("ERC20BatchSender", {
    contract: "ERC20BatchSenderV2",
    from: deployer,
    log: true,
    proxy: {
      proxyContract: 'UUPS',
      upgradeIndex: getUpgradeIndex(),
      upgradeFunction: {
        methodName: "upgradeToAndCall",
        upgradeArgs: ['{implementation}', '{data}']
      },
      execute: {
        init: {
          methodName: 'initialize',
          args: [
            deployer,
            whitelistCostPolicy,
            feeRecipient,
          ],
        },
        // To update costPolicy to whitelistCostPolicy.
        onUpgrade: {
          methodName: 'reinitialize',
          args: [
            whitelistCostPolicy,
            feeRecipient,
          ],
        }
      }
    }
  })
}

deployFn.tags = ["local", "testnet", "mainnet", "ERC20BatchSender"]

export default deployFn
