// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Voting is ERC20 {

    string question;
    string[3] answer;
    uint256 public timestamp;
    uint256 id;

    mapping(uint256 => uint256) votes; 
    mapping(address => bool) hasVoted;

    constructor(string memory _question, string[3] memory _answer, string memory _name, string memory _tag) ERC20(_name, _tag){
        question = _question;
        answer = _answer;
        timestamp = block.timestamp;
    }

    function mint(uint256 value) public {
        ERC20._mint(msg.sender, value);
    }
    
    function vote(uint8 _id) public {
        require(!hasVoted[msg.sender], "Vous avez deja vote");
        require(_id < answer.length, "Reponse invalide");
        require(block.timestamp < timestamp + 1 days, "Delais de vote depasse.");
        require(balanceOf(msg.sender) > 0, "vous devez posseder du CanVote pour voter.");

        votes[_id]++;
        hasVoted[msg.sender] = true;
    }

    function getVoteResult() public view returns(uint256[4] memory){
        return [votes[0],votes[1],votes[2],votes[3]]; 
    }

    function getQuestion() public view returns(string memory) {
        return question;
    }
 }