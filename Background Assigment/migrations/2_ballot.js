// This is needed for deploying the contract

// declare the contract we want to deploy
var Ballot = artifacts.require("Ballot.sol");

module.exports = async(deployer) => {
    // deployer is offer by ganache
    await deployer.deploy(Ballot,["0x436f6e7374616e74696e00000000000000000000000000000000000000000000", "0x53746566616e0000000000000000000000000000000000000000000000000000" ]);
    
    ballotInstance = await Ballot.deployed(); //ballotInstance.address

    balance = await web3.eth.getBalance(ballotInstance.address);

    await ballotInstance.giveRightToVote('0x78619d05490c971D3C2f30A1d0A06bA0108475c2');
    await ballotInstance.giveRightToVote('0xf70440b92182B2B46Cca2601f49d7485B1B375De');
    await ballotInstance.giveRightToVote('0xaa5B038e6c7235ceB52a867B7Fff3a6aA307F122');
    await ballotInstance.giveRightToVote('0x206DE363F0a5427630988E4b53414aAA97e30E1C');
    await ballotInstance.giveRightToVote('0x58b39fc51fF1E4931c3C2cbC2734fa9b1d479fE7');
    await ballotInstance.giveRightToVote('0x5C85E6f9824a90156D0f6C081c22DC81a451Fa60');
    await ballotInstance.giveRightToVote('0x647543811222A3060FE4922eEc89670817579a85');
    await ballotInstance.giveRightToVote('0x8d38FC64a314a2ba18305544859aDC0c072Ed72c');
    await ballotInstance.giveRightToVote('0xe10b7BdE766Ca6395F9ea3D30D21641c1516ea97');
    await ballotInstance.giveRightToVote('0x7E80d8c5d22D678564199dBBF1c920Fe73F27B9c');

    balance = await web3.eth.getBalance(ballotInstance.address);
    

};