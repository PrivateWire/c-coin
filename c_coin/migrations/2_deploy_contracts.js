var dAppToken = artifacts.require("./DappToken.sol");
var dAppTokenSale = artifacts.require("./DappTokenSale.sol");

//Deploy and export contract

module.exports = function(deployer) {
    deployer.deploy(dAppToken, 1000000).then(function() {
        // Token price is 0.001 Ether
        var tokenPrice = 1000000000000000;
        return deployer.deploy(dAppTokenSale, dAppToken.address, tokenPrice);
    });
};