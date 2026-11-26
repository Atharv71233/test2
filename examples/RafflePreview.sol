// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RafflePreview {
    function drawWinner(uint256 entrantCount) external view returns (uint256) {
        require(entrantCount > 0, "No entrants");
        return block.timestamp % entrantCount;
    }
}
