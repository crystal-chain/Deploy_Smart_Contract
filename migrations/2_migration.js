var Sac = artifacts.require("SacNFT");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(Sac);
};