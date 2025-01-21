// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "./Vote.sol";

contract VoteFactory is Ownable{
    address[] public votes;

    constructor() Ownable(msg.sender){}

    function createVote(string memory _question, string[3] memory _answer, string memory _name, string memory _tag) public onlyOwner(){
        Voting newVote = new Voting(_question, _answer, _name, _tag);
        votes.push(address(newVote));
    }

    function getVotes() public view returns(address[] memory){
        return votes; 
    }

    function getVote(uint8 id) public view returns(address){
        return votes[id];
    }

    function getVoteCount() public view returns(uint){
        return votes.length;
    }
}