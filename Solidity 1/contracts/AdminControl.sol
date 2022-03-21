// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract AdminControl {
    constructor(address[] memory _admins) {
        admins = _admins;
        admins.push(msg.sender);
    }

    // storage/ state/ persistent db
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

    // POST
    function addAdmin(address _admin) public onlyAdmins {
        admins.push(_admin);
    }

    // GET
    function getAdmins() external view returns (address[] memory) {
        return admins;
    }
}
