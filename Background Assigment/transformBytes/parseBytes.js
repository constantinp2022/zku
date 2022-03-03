// to run this node parseBytes.js someBytesToConvert

const ethers =  require('ethers');

async function parseBytes(args){
    const bytes = args[0];
    const name = ethers.utils.parseBytes32String(bytes);
    console.log("Name: ", name);
    console.log("Bytes: ", bytes);

}

parseBytes(process.argv.slice(2));