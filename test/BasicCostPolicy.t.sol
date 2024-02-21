// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "./TestBase.sol";

contract BasicCostPolicyTest is TestBase {
    function setUp() public override {
        super.setUp();
    }

    function test_calculateCost_WhenUserCountIsBiggerThanMaxFreeUserCount() public {
        assertEq(basicCostPolicy.calculateCost(ALICE, MIN_USER_COUNT + 1, 100, 0), basicCostPolicy.oneTimeFee());
    }

    function test_calculateCost_WhenUserCountIsLessOrEqualThanMaxFreeUserCount() public {
        assertEq(basicCostPolicy.calculateCost(ALICE, MIN_USER_COUNT, 100, 0), 0);
    }
}
