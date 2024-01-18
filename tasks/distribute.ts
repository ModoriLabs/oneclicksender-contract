import { task } from "hardhat/config";
import { BigNumber } from "ethers";
import { TaskArguments } from "hardhat/types";

const distribute = task("distribute", "Prints the list of accounts")
  .addFlag("dryrun")
  .addParam("startId")
  .addParam("endId")
  .setAction(async (taskArgs: TaskArguments, hre) => {
    const { deployer } = await hre.getNamedAccounts();
    const fs = require("fs");
    const path = require("path")
    const csvPath = path.join(__dirname, "data/MDUS.csv");
    console.log(csvPath)
    const csv = fs.readFileSync(csvPath, "utf-8");
    const rows = csv.split("\r\n");
    rows.pop() // last blank line

    console.log(rows.length)

    const chunksize = 200;
    const receivers = [];
    const amounts = [];
    let totalAmounts = BigNumber.from("0");

    for (const i in rows) {
      const row = rows[i]
      const data = row.split(",")
      const receiver = data[0]
      const amount = hre.ethers.utils.parseEther(data[1])
      totalAmounts = totalAmounts.add(amount)

      if(!receivers.length || receivers[receivers.length-1].length == chunksize) {
        receivers.push([]);
        amounts.push([]);
      }

      receivers[receivers.length-1].push(receiver);
      amounts[amounts.length-1].push(amount);
    }

    console.log("chunks.length: ", receivers.length)
    console.log("chunks[0].length : ", receivers[0].length)
    console.log("last chunk length: ", receivers[receivers.length - 1].length)
    console.log(amounts[amounts.length - 1])
    console.log("totalAmounts: ", totalAmounts);

    // MDUS
    let rewardAsset = "0xab9cb20a28f97e189ca0b666b8087803ad636b3c";

    const deployments = await hre.deployments.get("ERC20BatchSender");
    const contract = (await hre.ethers.getContractAt(
      deployments.abi,
      deployments.address
    )) as any;
    console.log(`contract: ${contract.address}`);

    const typeId = 0;
    const startId = Number(taskArgs.startId)
    const endId = Number(taskArgs.endId)
    console.log("startId: ", startId);
    console.log("endId: ", endId);

    if (!taskArgs.dryrun) {
      for (let id = startId; id <= endId; id++) {
        console.log("id: ", id);
        console.log("Send tx");
        const tx = await contract.send(rewardAsset, receivers[id], amounts[id], typeId);
        await tx.wait();
        console.log(tx);
      }
    } else {
      for (let id = startId; id <= endId; id++) {
        console.log("id: ", id);
        console.log("receivers[id]: ", receivers[id][0]);
        console.log("amounts[id]: ", amounts[id][0]);
        console.log("receivers[id].length: ", receivers[id].length);
        console.log("amounts[id].length: ", amounts[id].length);
        console.log("Skip tx in dryrun");
      }
    }
  });

export default distribute;
