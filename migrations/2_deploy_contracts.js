
var MetaCoin = artifacts.require("./Remittance.sol");
var MetaCoin = artifacts.require("./ExchangeShop.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.deploy(Remittance);
  deployer.deploy(ExchangeShop);
  deployer.link(ConvertLib, ExchangeShop.sol);
};
