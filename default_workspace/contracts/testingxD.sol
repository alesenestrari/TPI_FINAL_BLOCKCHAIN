// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Variables {
    // State variables are stored on the blockchain.
    string public text = "Hello";
    uint public num = 123;
    uint public count = 0;

    function doSomething() public {
        // Local variables are not saved to the blockchain.
        uint i = 456;

        if (i==456) {
            count += 1;
        }

        // Here are some global variables
        uint timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // address of the caller
    }
}