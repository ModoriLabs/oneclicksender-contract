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
ERC20BatchSenderV1 is deployed. To use WhitelistCostPolicy, use ERC20BatchSenderV2.

| Contracts        | Address                                                                                                              |
|------------------|----------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy  | [0x347D7fC3A0F1355672b003e92C7077e1FF1D3067](https://bscscan.com/address/0x347D7fC3A0F1355672b003e92C7077e1FF1D3067) |
| ERC20BatchSender | [0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238](https://bscscan.com/address/0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238) |

### Cypress (Klaytn)
ERC20BatchSenderV2 is deployed.

| Contracts           | Address                                                                                                                  |
|---------------------|--------------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy     | [0x347D7fC3A0F1355672b003e92C7077e1FF1D3067](https://klaytnscope.com/account/0x347D7fC3A0F1355672b003e92C7077e1FF1D3067) |
| ERC20BatchSender    | [0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238](https://klaytnscope.com/account/0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238) |
| WhitelistCostPolicy | [0x0dA42C1F37d1C138361f0e3F1743065dC0399975](https://klaytnscope.com/account/0x0dA42C1F37d1C138361f0e3F1743065dC0399975) |


### Testnet
#### BSC Testnet

| Contracts        | Address                                                                                                                      |
|------------------|------------------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy  | [0xE7e332601c6E2280DD509d9aa1452B607889E1de](https://testnet.bscscan.com/address/0xE7e332601c6E2280DD509d9aa1452B607889E1de) |
| ERC20BatchSender | [0x7ADFDeEe2Abe60ED061591cccdb909b24aE650ce](https://testnet.bscscan.com/address/0x7ADFDeEe2Abe60ED061591cccdb909b24aE650ce) |
| MockERC20        | [0x154EE4fD84f4F14A5d13C3fAa4088F1eCf81a5Da](https://testnet.bscscan.com/address/0x154EE4fD84f4F14A5d13C3fAa4088F1eCf81a5Da) |

#### Baobab (Klaytn Testnet)

| Contracts        | Address                                                                                                                         |
|------------------|---------------------------------------------------------------------------------------------------------------------------------|
| BasicCostPolicy  | [0x58303615221a683C1c028C4047238B3aCDD97d9e](https://baobab.klaytnscope.com/account/0x58303615221a683C1c028C4047238B3aCDD97d9e) |
| ERC20BatchSender | [0xc2e8fA68082d3cbeC24642c348290Bb595133C2C](https://baobab.klaytnscope.com/account/0xc2e8fA68082d3cbeC24642c348290Bb595133C2C) |
| MockERC20        | [0xD682f0D6673Eb1A9829099877658902EFe5e90EE](https://baobab.klaytnscope.com/account/0xD682f0D6673Eb1A9829099877658902EFe5e90EE) |


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
