pragma solidity ^0.6.0;

import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

contract Overflow {
    
    using SafeMath for uint256;

    mapping (address => uint256) public balanceOf;

    constructor() public {
        balanceOf[msg.sender] = 2**256 - 1;
    }

    function transferInsecure(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }

    receive() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    function transferSecure(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value && balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }
    
    function usingLibrary (address _to, uint256 _value) public {
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
    }
}
