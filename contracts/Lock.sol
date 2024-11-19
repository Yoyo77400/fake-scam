// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Lock {
    uint public unlockTime;
    address payable public owner;
    error TimesShouldBeInTheFuture(uint);

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) payable {
        // require(
        //     block.timestamp < _unlockTime,
        //     "Unlock time should be in the future"
        // );   (plus optimisé, nouvelle façon de faire ci dessous)
        if(block.timestamp > _unlockTime){
            revert TimesShouldBeInTheFuture(_unlockTime);
        }

        unlockTime = _unlockTime;
        owner = payable(msg.sender);

        payable(address(this)).transfer(msg.value);
    }

    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");
        
        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }
}
