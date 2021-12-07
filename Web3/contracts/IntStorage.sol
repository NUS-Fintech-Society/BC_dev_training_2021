// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntStorage {
    uint256 private data;
    address private owner;

    modifier dataIsThree() {
        require(data == 3, "Data is not 3");
        _;
    }

    modifier onlyPayment() {
        require(msg.value > 0, "No money, no honey");
        _;
    }

    function getData() external view returns (uint256) {
        return data;
    }

    function setData(uint256 _data) external {
        data = _data;
    }

    function setOwner() external payable dataIsThree onlyPayment {
        owner = msg.sender;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}
