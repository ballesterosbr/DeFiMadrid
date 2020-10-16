// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract CrowdfundingSec {
    
    uint public finalAmount = 3 ether;
    uint public totalAmount;

    address public owner; 
    enum State {Inactive, Active}
    State public status;

    mapping(address => uint) balanceOf;
    
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    constructor() {    
        owner = msg.sender; 
    }

    function fund() public payable {
        require(msg.value == 1 ether);
        require(totalAmount <= finalAmount);
        balanceOf[msg.sender] += msg.value;
        totalAmount += msg.value;
    }
    
    function changeState() public onlyOwner {
        require(totalAmount == finalAmount);
        require(status == State.Inactive);
        status = State.Active;
    }

    function getMemberBalance() public view returns (uint256) {
        return balanceOf[msg.sender];
    }
    
    function getTotalBalance() public view returns (uint256) {
        return totalAmount;
    }
    
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
           
    receive() external payable{
        revert();
    }
}
