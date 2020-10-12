pragma solidity ^0.7.0;

contract Crowdfunding {
    
    uint public finalAmount = 3 ether;

    mapping(address => uint) balanceOf;
    
    function fund() public payable {
        require(msg.value == 1 ether);
        require(address(this).balance <= finalAmount);
        balanceOf[msg.sender] += msg.value;
    }
    
    function getMemberBalance() public view returns (uint256) {
        return balanceOf[msg.sender];
    }
    
    function getTotalBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function withdrawFund() public {
        require(address(this).balance == finalAmount);
        uint amount = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
    
    receive() external payable {
        revert();
    }
}   
