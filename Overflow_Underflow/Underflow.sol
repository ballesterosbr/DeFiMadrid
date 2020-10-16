// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/SafeCast.sol";

contract Underflow {

    using SafeMath for uint8;
    
    mapping (address => uint8) public votes;

    function undoVote(address _address) public {
        votes[_address] -= 1;
    }
    
    function usingLibrary (address _address) public {
        votes[_address] = SafeCast.toUint8(votes[_address].sub(1));
    }
}
