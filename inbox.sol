// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;


contract Inbox {
    string public message;

    constructor (string memory initialMessage) public {
        message = initialMessage;
    }

    function setMessage(string memory newMessage) public returns (string memory) {
        message = newMessage;
    }
}
