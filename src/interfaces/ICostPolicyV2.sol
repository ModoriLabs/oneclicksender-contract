// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

interface ICostPolicyV2 {
    function calculateCost(
        address token,
        address sender,
        uint256 userCount,
        uint256 totalAmount,
        uint256 typeId
    )
        external
        view
        returns (uint256 cost);
}
