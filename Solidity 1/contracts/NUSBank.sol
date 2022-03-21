// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./AdminControl.sol";

contract NUSBank is AdminControl {
    // state/storage
    mapping(address => uint256) private balances;

    constructor(address[] memory _admins) AdminControl(_admins) {}

    function deposit() public payable returns (uint256) {
        // require((balances[msg.sender] + msg.value) >= balances[msg.sender]);
        balances[msg.sender] += msg.value;
        return balances[msg.sender];
    }

    function withdraw(uint256 _withdrawAmount) public returns (uint256) {
        require(_withdrawAmount <= balances[msg.sender]);

        balances[msg.sender] -= _withdrawAmount;

        payable(msg.sender).transfer(_withdrawAmount);

        return balances[msg.sender];
    }

    function balance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
