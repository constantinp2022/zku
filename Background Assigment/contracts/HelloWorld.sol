
// Date: 2022 March 02
// Author constantinp2022@zku

//

/*
Worth mentioning:
I. OS Systems used was linux distribution vesion ubuntu
II. Commads run before:
    a. sudo apt install npm
    b. sudo apt install git
    c. install node
    d. sudo npm install ganache --global
    e. install vscode
    f. install vscode extension solidity
    g. install vscode extension Blockchain Development Kit for Ethereum by Microsoft
*/  

// 1. A compiler with the same version as pragma solidity must be used. A version range may be mentioned.
// 2. VSCode was used as editor
// 3. For compiling Solidity extension publisher:"Juan Blanco"
// 4. For deploying Blockchain Development Kit for Ethereum by Microsoft
// 5. For point 4. Truffle Node.js, GIT, NPM must be installed and Ganache CLI

// Simple start
// 1. select a folder truffle init
// 2. truffle compile
// 3. start ganache by running the command in a terminal and modify the truffle-config.js if neccesary 
// 4. truffle migrate - For deploy 


pragma solidity 0.6.0; //1. Enter solidity version here

//2. Create contract here
contract HelloWorld
{
    string stringHelloWorld = "Hello World!"; // Visibility is set automatically to intern to null and value 0 is set for int
    uint256 simpleInt;

    // Just a simple function to return a string Hello
    function readHello() public view returns(string memory){
        return stringHelloWorld;
    }

}