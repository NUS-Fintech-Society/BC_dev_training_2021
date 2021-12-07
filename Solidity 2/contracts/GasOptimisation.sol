// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract GasOptimisation {
    struct BadStruct {
        uint128 id;
        uint256 amount;
        uint128 multiplier;
    }

    struct GoodStruct {
        uint128 id;
        uint128 multiplier;
        uint256 amount;
    }

    // storage
    BadStruct b;
    GoodStruct g;

    string ss; // 2 bytes or 2000 bytes
    bytes32 bb; // fixed 32 bytes

    function badFunc() external {
        b = BadStruct({id: 1, multiplier: 2, amount: 3});
    }

    function goodFunc() external {
        g = GoodStruct({id: 1, multiplier: 2, amount: 3});
    }

    address otherContract;

    function dgDemo() external {
        (bool success, bytes memory result) = otherContract.delegatecall(
            abi.encodeWithSignature("add(uint256,uint256)", 1, 2)
        );
    }
}
