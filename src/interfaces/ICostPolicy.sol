// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

interface CostPolicy {
    function calculateCost(uint256 userCount) external view returns (uint256);
}
