// This is needed for deploying the contract

// declare the contract we want to deploy
var HelloWorld = artifacts.require("HelloWorld");

module.exports = function(deployer) {
    // deployer is offer by ganache
    deployer.deploy(HelloWorld);
};