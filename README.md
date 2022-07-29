# DEPLOY_SMART_CONTRACT

Vous pouvez simplement install les dépendencies avec "npm install".

## Installer Truffle (Démarrer le projet)
```
npm install -g truffle
```
Démarrer le projet Truffle
```
truffle init
```
Si besoin, on peut également choisir la version du compiler dans le fichier *truffle-config.js* qui se crée à l'initialisation du projet Truffle.
Truffle est l'outil idéal pour la création et le déploiement de smart contract. Vous pouvez accéder à plus de documentation sur la page officielle https://trufflesuite.com/docs/truffle/


## Fonctions ERC721

Importation de la librairie OpenZeppelin, donnant une implémentation de contrats pouvant être utilisés pour construire des tokens ERC721 (entre autres), avec la commande:\
```
npm install @openzeppelin/contracts
```
On utilise le contrat ERC721URIStorage qui hérite de ERC721 en ajoutant le storage URI, les fonctions de transfert, ownerOf, exists sont appelables puisque le contrat est un ERC721.

## Smart contract

On définit 2 roles principaux, Owner et Minter. Owner correspond à Crystalchain qui est le créateur du contrat, Minter correspond à des adresses ethereum Chanel (ou du client) qui ont la permission de "Mint" des NFT.
Les modifier permettent de gérer ces rôles, on aurait pu utiliser le contract Ownable de OpenZeppelin aussi.


## Déploiement

Il faut tout d'abord créer un fichier .secret ou vous allez simplement écrire la mnemonic de votre wallet avec lequel vous voulez déployer le contrat.
 ```
 const mnemonic = fs.readFileSync(".secret").toString().trim();
 ```
 dans truffle-config.js permet de lire ce secret afin de déployer le contrat.

Pour ajouter un réseau, il suffit simplement d'ajouter dans le fichier "truffle-config.js" un nouveau network avec le endpoint et network_id correspondant.
Déployer sur le réseau choisi, à configurer dans le fichier truffle-config.js
```
truffle migrate --network rinkeby
```


## Vérifier le contrat sur Etherscan pour obtenir son ABI

Pour flatten le contrat et le vérifier sur Etherscan 
```
sol-merger --remove-comments "./contracts/SacNFT.sol" ./merged
```

## Développement

Une fois le contrat déployé, vous pouvez vous rendre dans la console truffle sur le réseau correspodant 
```
truffle console --network rinkeby
```
Puis exécuter les fonctions du contrat directement en console, c'est le plus pratique pour le déploiement et vérifier la validité des fonctions.
```
nft = await SacNFT.deployed() //pour obtenir le last deployed
await nft.name()
await nft.symbol()
await nft.generateSac("0x0445c33bdce670d57189158b88c0034b579f37ce", tokenURI ) # adresse du minter qui va recevoir le NFT
await nft.ownerOf(0)
await nft.tokenURI(0)
nft.address
https://rinkeby-api.opensea.io/asset/[nft contract address]/[token id]/validate
https://rinkeby.opensea.io/assets/[nft contract address]/[token id]
```