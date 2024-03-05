# OneClickSender

## Test
```shell
# To run unit tests
forge test --no-match-contract ForkE2ETest

# To run E2E tests
forge test --match-contract ForkE2ETest
```

## Deploy
```sh
pnpm hardhat deploy --network bsc --tags mainnet
```

## Deployments

- Fee recipient: 0x509477dc6ab2ee4ee42765a90420da2c2cf2d165

### Mainnet
ERC20BatchSenderV1 is deployed. To use WhitelistCostPolicy, use ERC20BatchSenderV2.

| Contracts        | Address                                                                                                               |
|------------------|-----------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy  | [0xD70b9239a89e6D56ea6661627cb710B98FF100DA](https://etherscan.io/address/0xD70b9239a89e6D56ea6661627cb710B98FF100DA) |
| ERC20BatchSender | [0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238](https://etherscan.io/address/0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238) |

### BSC
ERC20BatchSenderV2 is deployed.

| Contracts           | Address                                                                                                              |
|---------------------|----------------------------------------------------------------------------------------------------------------------|
| ERC20BatchSender    | [0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238](https://bscscan.com/address/0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238) |
| WhitelistCostPolicy | [0xD70b9239a89e6D56ea6661627cb710B98FF100DA](https://bscscan.com/address/0xD70b9239a89e6D56ea6661627cb710B98FF100DA) |


### Polygon
ERC20BatchSenderV2 is deployed.

| Contracts           | Address                                                                                                                  |
|---------------------|--------------------------------------------------------------------------------------------------------------------------|
| ERC20BatchSender    | [0xF4f31C62AEF4Ec3F0429dc48F95dF10B1146F7D0](https://polygonscan.com/address/0xF4f31C62AEF4Ec3F0429dc48F95dF10B1146F7D0) |
| WhitelistCostPolicy | [0x347d7fc3a0f1355672b003e92c7077e1ff1d3067](https://polygonscan.com/address/0x347d7fc3a0f1355672b003e92c7077e1ff1d3067) |

### Cypress (Klaytn)
ERC20BatchSenderV2 is deployed.

| Contracts           | Address                                                                                                                  |
|---------------------|--------------------------------------------------------------------------------------------------------------------------|
| ERC20BatchSender    | [0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238](https://klaytnscope.com/account/0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238) |
| WhitelistCostPolicy | [0x0dA42C1F37d1C138361f0e3F1743065dC0399975](https://klaytnscope.com/account/0x0dA42C1F37d1C138361f0e3F1743065dC0399975) |


### Testnet
#### BSC Testnet

| Contracts           | Address                                                                                                                      |
|---------------------|------------------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy     | [0xf10f481c24D2D2575397772e90EEF10637e66d61](https://testnet.bscscan.com/address/0xf10f481c24D2D2575397772e90EEF10637e66d61) |
| ERC20BatchSender    | [0x08edA7169C4Cc55f75e93d8B6FB4A8F2C4FC8FeF](https://testnet.bscscan.com/address/0x08edA7169C4Cc55f75e93d8B6FB4A8F2C4FC8FeF) |
| MockERC20           | [0x154EE4fD84f4F14A5d13C3fAa4088F1eCf81a5Da](https://testnet.bscscan.com/address/0x154EE4fD84f4F14A5d13C3fAa4088F1eCf81a5Da) |
| WhitelistCostPolicy | [0x9F8A97c577c69995db4B60a60a20aBA45dE6403e](https://testnet.bscscan.com/address/0x9F8A97c577c69995db4B60a60a20aBA45dE6403e) |

#### Mumbai

| Contracts           | Address                                                                                                                         |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy     | [0x2f8270A3c097103C2565b74160c22917f6173Ae9](https://mumbai.polygonscan.com/address/0x2f8270A3c097103C2565b74160c22917f6173Ae9) |
| ERC20BatchSender    | [0x7506c621edBEfD7Ba344c98ff716111AaE3EA226](https://mumbai.polygonscan.com/address/0x7506c621edBEfD7Ba344c98ff716111AaE3EA226) |
| MockERC20           | [0xb5c26A5407f91B7FE0458338854C3604099593a5](https://mumbai.polygonscan.com/address/0xb5c26A5407f91B7FE0458338854C3604099593a5) |
| WhitelistCostPolicy | [0xf8813698A4f5282c403eD835b6F54C05F51C7649](https://mumbai.polygonscan.com/address/0xf8813698A4f5282c403eD835b6F54C05F51C7649) |

#### Baobab (Klaytn Testnet)

| Contracts           | Address                                                                                                                         |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy     | [0x58303615221a683C1c028C4047238B3aCDD97d9e](https://baobab.klaytnscope.com/account/0x58303615221a683C1c028C4047238B3aCDD97d9e) |
| ERC20BatchSender    | [0xc2e8fA68082d3cbeC24642c348290Bb595133C2C](https://baobab.klaytnscope.com/account/0xc2e8fA68082d3cbeC24642c348290Bb595133C2C) |
| MockERC20           | [0xD682f0D6673Eb1A9829099877658902EFe5e90EE](https://baobab.klaytnscope.com/account/0xD682f0D6673Eb1A9829099877658902EFe5e90EE) |
| WhitelistCostPolicy | [0x1d517308435eF5f9d6D6d6E75AbB0BBbda017A2D](https://baobab.klaytnscope.com/account/0x1d517308435eF5f9d6D6d6E75AbB0BBbda017A2D) |


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
