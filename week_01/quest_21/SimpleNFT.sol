// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";


contract SimpleNFT is ERC721, Ownable {
    uint256 public mintPrice = 0.05 ether;
    uint256 public totalSupply;
    uint256 public maxSupply = 2;
    bool public isMintEnabled = true;

    // A mapping between addresses and tokenID
    mapping (address => uint256) public mintedwallets;

    //Main constructor with name  and symbol as input
    constructor() payable ERC721('Simple Mint', 'SIMPLEMINT') {
    }

    //Toggle mint process
    function toggleIsMintEnabled () external onlyOwner {
    isMintEnabled = !isMintEnabled;
    }

    //Set maximul supply of NFTs
    function setMaxSupply(uint256 maxSupply_) external onlyOwner{
        maxSupply = maxSupply_;
    }

    function mint(address receiver_of_NFT) external payable
        returns (uint256){

        //Check minting is enabled
        require(isMintEnabled, 'Minting not Enabled');

        //No more than one NFT per wallet
        require(mintedwallets[receiver_of_NFT] < 1, 'exceeds max per wallet');

        // Check if sender sent the right amount 
        require(msg.value == mintPrice, 'wrong value');

        //Check that the totalSupply is not bigger than maxSupply
        require(maxSupply > totalSupply, 'SOLD OUT');

        //Increase size of own NFT for receiver
        mintedwallets[receiver_of_NFT]++;

        //Increase total NFT supply
        totalSupply++;

        //TokenID is the same number as totalSupply
        uint256 tokenId = totalSupply;

        //Actual mint 
        _mint(receiver_of_NFT, tokenId);
        // _setTokenURI(tokenId, tokenURI);

        //Return tokenId
        return tokenId;

    }

    function tokenURI(uint256 tokenId)
        public
        pure
        override
        returns (string memory)
    {

        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "SimpleNFT #'
                ,Strings.toString(tokenId), '"',
                '"description": "Custom Token #'
                , Strings.toString(tokenId), '"',
            '}'
        );

        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }

}