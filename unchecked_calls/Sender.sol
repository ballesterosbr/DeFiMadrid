pragma solidity ^0.7.0;

contract Sender {
    
    function send(address payable _receiver) public payable {
        _receiver.transfer(msg.value);
    }
}

contract Receiver {
    
    receive() external payable {}
    
    function getBalance() public view returns (uint256) {
        return (address(this).balance);
    }
}

contract ReceiverException {
    
    receive() external payable {
        require(msg.sender == address(0));
    }
    
    function getBalance() public view returns (uint256){
        return (address(this).balance);
    }
}

contract SenderException {
        
    uint256 x;
    
    function getX() public view returns (uint256) {
        return x;
    }
    
    function getBalance() public view returns (uint256) {
        return (address(this).balance);
    }
    
    function send(address payable _receiver) public payable {
        _receiver.send(msg.value);
        x = 3;
    }
}

contract SenderSecure {
        
    uint256 x;
    function getX() public view returns (uint256){
        return x;
    }
    
    function getBalance() public view returns (uint256){
        return (address(this).balance);
    }
    
    function send(address payable _receiver) public payable {
        require(_receiver.send(msg.value));
        x = 3;
    }
}
