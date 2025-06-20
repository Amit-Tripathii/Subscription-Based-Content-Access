// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SubscriptionAccess {
    address public owner;
    uint256 public subscriptionFee;
    mapping(address => uint256) public subscribers;

    constructor(uint256 _fee) {
        owner = msg.sender;
        subscriptionFee = _fee;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    modifier isSubscribed() {
        require(subscribers[msg.sender] >= block.timestamp, "Not subscribed");
        _;
    }

    function subscribe(uint256 durationInDays) external payable {
        require(msg.value == subscriptionFee * durationInDays, "Incorrect payment");
        subscribers[msg.sender] = block.timestamp + (durationInDays * 1 days);
    }

    function checkSubscription(address user) external view returns (bool) {
        return subscribers[user] >= block.timestamp;
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
