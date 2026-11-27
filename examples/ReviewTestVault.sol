// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Deliberately insecure scanner fixture. Never deploy or fund this contract.
contract ReviewTestVault {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function changeOwner(address newOwner) external {
        owner = newOwner;
    }

    function withdraw(address payable recipient) external {
        require(msg.sender == owner, "Only owner");
        (bool success, ) = recipient.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }
}
