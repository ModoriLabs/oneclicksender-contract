import { task } from "hardhat/config";

export const upgrade = task("upgrade", "")
  .setAction(async (taskArgs, hre) => {
    const { deployments } = hre;
    const { log } = deployments;

    const erc20BatchSender = await deployments.get("ERC20BatchSender");
    const impl = await deployments.get("ERC20BatchSender_Implementation");
    console.log("impl.address: ", impl.address);

    const erc20BatchSenderContract = await hre.ethers.getContractAt(
      erc20BatchSender.abi,
      erc20BatchSender.address
    );

    let ABI = [
      "function reinitialize(address _costPolicy, address _feeRecipient)"
    ];
    let iface = new hre.ethers.utils.Interface(ABI);
    const data = iface.encodeFunctionData(
      "reinitialize",
      ["0x347d7fc3a0f1355672b003e92c7077e1ff1d3067", "0x509477dc6AB2EE4eE42765A90420DA2c2CF2d165"]
    )
    console.log("data: ", data);

    const upgradeTx = await erc20BatchSenderContract.upgradeToAndCall(impl.address, data)
    await upgradeTx.wait();

    log("Upgrade successful");
  })
