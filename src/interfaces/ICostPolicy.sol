// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

interface ICostPolicy {
    function calculateCost(
        address sender,
        uint256 userCount,
        uint256 totalAmount,
        uint256 typeId
    )
        external
        view
        returns (uint256 cost);
}
