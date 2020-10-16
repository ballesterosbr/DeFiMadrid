// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract Transfers {
    
    mapping(address => uint256) balanceOf;
    
    // NOT RECOMMENDED
    function withdrawInsecure() external {
        uint256 amount = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        msg.sender.transfer(amount);
    }

    // VULNERABLE
    function withdrawMidSecure() external {
        uint256 amount = balanceOf[msg.sender];
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");    
        balanceOf[msg.sender] = 0;
    }
    
    // SECURE
    function withdrawSecure() external {
        uint256 amount = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
    }
    
    receive() external payable {
        balanceOf[msg.sender] += msg.value;
    }
}
