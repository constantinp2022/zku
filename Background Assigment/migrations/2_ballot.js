// This is needed for deploying the contract

// declare the contract we want to deploy
var Ballot = artifacts.require("Ballot.sol");

module.exports = function(deployer) {
    // deployer is offer by ganache
    deployer.deploy(Ballot,["0x436f6e7374616e74696e00000000000000000000000000000000000000000000", "0x53746566616e0000000000000000000000000000000000000000000000000000" ]);
};