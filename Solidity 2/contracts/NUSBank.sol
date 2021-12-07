// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./AdminControl.sol";

contract NUSBank is AdminControl {
    mapping(address => uint256) private balances;

    event Deposit(address indexed depositor, uint256 amount);
    event Withdrawal(address indexed withdrawer, uint256 amount);

    constructor(address[] memory _admins) AdminControl(_admins) {}

    function balance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function balanceOf(address _address) internal view returns (uint256) {
        return balances[_address];
    }

    function deposit() public payable virtual {
        // require((balances[msg.sender] + msg.value) >= balances[msg.sender]);

        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _withdrawAmount) public virtual {
        require(_withdrawAmount <= balances[msg.sender], "Not Enough Funds");

        balances[msg.sender] -= _withdrawAmount;

        payable(msg.sender).transfer(_withdrawAmount);

        emit Deposit(msg.sender, _withdrawAmount);
    }
}
