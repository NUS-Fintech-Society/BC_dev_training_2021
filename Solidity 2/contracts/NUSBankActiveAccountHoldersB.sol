// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./NUSBank.sol";

contract NUSBankActiveAccountHoldersB is NUSBank {
    address[] private activeAddresses;

    constructor(address[] memory _admins) NUSBank(_admins) {}

    function getActiveAddresses() external view returns (address[] memory) {
        address[] memory tempSet = new address[](activeAddresses.length);
        uint256 tempSetIndex = 0;

        for (uint256 i = 0; i < activeAddresses.length; i++) {
            if (balanceOf(activeAddresses[i]) > 0) {
                // check if current address is already in tempSet
                bool isInSet = false;
                for (uint256 j = 0; j < tempSetIndex; j++) {
                    if (activeAddresses[i] == tempSet[j]) {
                        isInSet = true;
                        break;
                    }
                }

                // add to tempSet
                if (!isInSet) {
                    tempSet[tempSetIndex++] = activeAddresses[i];
                }
            }
        }

        address[] memory ret = new address[](tempSetIndex);

        // copy tempSet into ret
        for (uint256 i = 0; i < tempSetIndex; i++) {
            ret[i] = tempSet[i];
        }

        return ret;
    }

    function deposit() public payable override {
        if (balance() == 0) {
            activeAddresses.push(msg.sender);
        }
        super.deposit();
    }

    function withdraw(uint256 _withdrawalAmount) public override {
        super.withdraw(_withdrawalAmount);
    }
}
