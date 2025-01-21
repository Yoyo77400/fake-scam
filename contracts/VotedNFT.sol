// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract VotedNFT is ERC721 {

    mapping(address => bool) whiteList;
    mapping(address => uint8) accountQuantity;

    error mintWlError(bool , bool);
    error alreadyMint(uint, uint);

    constructor(string memory _name, string memory _tag) ERC721(_name, _tag){}

    function addWhiteList(address whiteListed) public {
        whiteList[whiteListed] = true ;
    }

    function mintNFT() external payable {
        require(whiteList[msg.sender] == true, mintWlError(true, whiteList[msg.sender]));
        require(accountQuantity[msg.sender] == 0, alreadyMint(0, accountQuantity[msg.sender]));
        
        _safeMint(msg.sender, 1);
    }

}