// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract VotedNFT is ERC721 {

    constructor(string memory _name, string memory _tag) ERC721(_name, _tag){}

}