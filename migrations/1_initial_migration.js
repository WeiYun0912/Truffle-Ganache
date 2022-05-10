const CryptoCurrencyStore = artifacts.require("CryptoCurrencyStore");

module.exports = function (deployer) {
  deployer.deploy(CryptoCurrencyStore);
};
