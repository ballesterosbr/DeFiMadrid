// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

// VULNERABLE
contract Reentrancy {

    mapping (address => uint) public balances;

    constructor() payable {
        setEther();
    }

    function setEther() public payable {
        balances[msg.sender] = msg.value;
    }

    function withdrawEther() public{
        (bool success, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(success);
        balances[msg.sender] = 0;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    receive() external payable{
        revert();
    }
}
