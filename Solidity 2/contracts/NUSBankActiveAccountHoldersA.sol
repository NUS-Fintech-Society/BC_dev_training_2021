// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./NUSBank.sol";

contract NUSBankActiveAccountHoldersA is NUSBank {
    address[] private activeAddresses;

    constructor(address[] memory _admins) NUSBank(_admins) {}

    function getActiveAddresses() external view returns (address[] memory) {
        return activeAddresses;
    }

    function deposit() public payable override {
        if (balance() == 0) {
            activeAddresses.push(msg.sender);
        }
        super.deposit();
    }

    function withdraw(uint256 _withdrawalAmount) public override {
        super.withdraw(_withdrawalAmount);

        if (balance() == 0) {
            // deleting from active address
            uint256 indexToDelete = 0;

            for (uint256 i = 0; i < activeAddresses.length; i++) {
                if (activeAddresses[i] == msg.sender) {
                    indexToDelete = i;
                    break;
                }
            }

            activeAddresses[indexToDelete] = activeAddresses[
                activeAddresses.length - 1
            ];
            activeAddresses.pop();
        }
    }
}
