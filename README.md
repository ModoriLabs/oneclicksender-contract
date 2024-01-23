# OneClickSender

## Deployments

### Mainnet

| Contracts        | Address                                                                                                               |
|------------------|-----------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy  | [0xD70b9239a89e6D56ea6661627cb710B98FF100DA](https://etherscan.io/address/0xD70b9239a89e6D56ea6661627cb710B98FF100DA) |
| ERC20BatchSender | [0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238](https://etherscan.io/address/0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238) |

### BSC Testnet

| Contracts        | Address                                                                                                                      |
|------------------|------------------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy  | [0xE7e332601c6E2280DD509d9aa1452B607889E1de](https://testnet.bscscan.com/address/0xE7e332601c6E2280DD509d9aa1452B607889E1de) |
| ERC20BatchSender | [0x7ADFDeEe2Abe60ED061591cccdb909b24aE650ce](https://testnet.bscscan.com/address/0x7ADFDeEe2Abe60ED061591cccdb909b24aE650ce) |
| MockERC20        | [0x154EE4fD84f4F14A5d13C3fAa4088F1eCf81a5Da](https://testnet.bscscan.com/address/0x154EE4fD84f4F14A5d13C3fAa4088F1eCf81a5Da) |

## Tasks

### distribute

Params
- file: a file path relative to `tasks/distribute.ts`
- startId: inclusive
- endId: inclusive

```shell
# To dryrun
pnpm hardhat distribute --network mumbai --file data/MDUS.csv --dryrun --start-id 0 --end-id 2

# To distribute in real
pnpm hardhat distribute --network polygon --file data/MDUS.csv --start-id 0 --end-id 0
```
