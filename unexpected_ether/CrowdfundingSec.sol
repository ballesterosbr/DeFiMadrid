pragma solidity ^0.7.0;

contract CrowdfundingSec {
    
    uint public finalAmount = 3 ether;
    uint public totalAmount;

    mapping(address => uint) balanceOf;
    
    function fund() public payable {
        require(msg.value == 1 ether);
        require(totalAmount <= finalAmount);
        balanceOf[msg.sender] += msg.value;
        totalAmount += msg.value;
    }
    
    function getMemberBalance() public view returns (uint256) {
        return balanceOf[msg.sender];
    }
    
    function getTotalBalance() public view returns (uint256) {
        return totalAmount;
    }
    
    function withdrawFund() public {
        require(totalAmount == finalAmount);
        uint amount = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        totalAmount -= amount;
        msg.sender.transfer(amount);
    }
    
    receive() external payable{
        revert();
    }
}
