const { assert } = require("console");

// Import contract
const HelloWorld = artifacts.require('HelloWorld.sol');

//Run test suite
contract('HelloWorld', ()=> {

    //A simple test to check the receive input
    it('should display Hello World!', async () => {
    
        //Initialize a contract
        const displayString = await HelloWorld.new();
        //call the method
        const result = await displayString.readHello();

        //Check result
        assert(result == 'Hello World!');
    });
});