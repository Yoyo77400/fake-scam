// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract VotedNFT is ERC721 {

    mapping(address => bool) whiteList;

    constructor(string memory _name, string memory _tag) ERC721(_name, _tag){}

    function addWhiteList(address whiteListed) public {
        whiteList[whiteListed] = true ;
    }

}