// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuditBranchCommitTest {
    address public owner;

    function becomeOwner() public {
        owner = msg.sender;
    }

    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}
