// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdsale {
    address public owner;
    uint256 public rate; // Rate of token per Ether
    uint256 public totalRaised;
    bool public isFinalized;

    mapping(address => uint256) public balances;

    event TokensPurchased(address indexed purchaser, uint256 amount);
    event CrowdsaleFinalized();

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor(uint256 _rate) {
        require(_rate > 0, "Rate must be greater than zero");
        owner = msg.sender;
        rate = _rate;
    }

    function buyTokens() public payable {
        require(!isFinalized, "Crowdsale is finalized");
        require(msg.value > 0, "Must send ETH to purchase tokens");

        uint256 tokens = msg.value * rate;
        balances[msg.sender] += tokens;
        totalRaised += msg.value;

        emit TokensPurchased(msg.sender, tokens);
    }

    function finalizeCrowdsale() public onlyOwner {
        require(!isFinalized, "Crowdsale already finalized");
        isFinalized = true;
        emit CrowdsaleFinalized();
    }

    function withdrawFunds() public onlyOwner {
        require(isFinalized, "Crowdsale not yet finalized");
        payable(owner).transfer(address(this).balance);
    }
}
