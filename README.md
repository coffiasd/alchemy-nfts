# alchemy-nfts

This project is about to make NFTs with On-Chain Metadata with hardhat && Javascript.

## About Polygon , Why use it ?

- Lower Gas Fees(10,000x lower gas costs per transaction than Ethereum)

- Faster Transactions (65,000 tx/seconds vs ~14)

## How to get free testnet Matic?

- mumbaifaucet.com
- faucet.polygon.technology

## init our project with hardhat

run npx init command
and then add OpenZeppelin smart contract library to our project
add dotenv library to our project too. It's useful when we need to add a .env config file which we don't need to commit to our git repo.

```
npm init
npx hardhat init
npm i --save @openzeppelin/contracts
npm i --save dotenv
```

## features

- generateCharacter: to generate and update the SVG image of our NFT
- getLevels : return the level of the NFT.
- getTokenURI : get the TokenURL of an NFT
- mint: of course we need to mint
- train: train an NFT and raise its level.
