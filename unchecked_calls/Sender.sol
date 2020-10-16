// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract Sender {
    
    function send(address payable _receiver) public payable {
        _receiver.transfer(msg.value);
    }
}

contract Receiver {
    
    function getBalance() public view returns (uint256) {
        return (address(this).balance);
    }

    receive() external payable {}
}

contract ReceiverException {
    
    function getBalance() public view returns (uint256) {
        return (address(this).balance);
    }
 
    receive() external payable {
        revert();
    }
}

contract SenderNotSecureException {
        
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
    function getX() public view returns (uint256) {
        return x;
    }
    
    function getBalance() public view returns (uint256) {
        return (address(this).balance);
    }
    
    function send(address payable _receiver) public payable {
        require(_receiver.send(msg.value));
        x = 3;
    }
}
