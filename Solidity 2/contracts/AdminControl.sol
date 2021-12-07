// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract AdminControl {
    constructor(address[] memory _admins) {
        admins = _admins;
        admins.push(msg.sender);
    }

    address[] private admins;

    modifier onlyAdmins() {
        bool isAdmin = false;
        for (uint256 i = 0; i < admins.length; i++) {
            if (admins[i] == msg.sender) {
                isAdmin = true;
                break;
            }
        }
        require(isAdmin, "Caller is not an admin");
        _;
    }

    function addAdmin(address _admin) public onlyAdmins {
        admins.push(_admin);
    }

    function getAdmins() external view returns (address[] memory) {
        return admins;
    }
}
