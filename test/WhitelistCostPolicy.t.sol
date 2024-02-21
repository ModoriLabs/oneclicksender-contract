// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "./TestBase.sol";

contract WhitelistCostPolicyTest is TestBase {
    error OwnableUnauthorizedAccount(address account);

    function setUp() public override {
        super.setUp();
        whitelistCostPolicy;
    }

    function test_CalculateCost_WhenUserCountIsBiggerThanMaxFreeUserCount() public {
        assertEq(whitelistCostPolicy.calculateCost(ALICE, MIN_USER_COUNT + 1, 100, 0), whitelistCostPolicy.oneTimeFee());
    }

    function test_CalculateCost_WhenUserCountIsLessOrEqualThanMaxFreeUserCount() public {
        assertEq(whitelistCostPolicy.calculateCost(ALICE, MIN_USER_COUNT, 100, 0), 0);
    }

    function test_CalculateCost_WhenUserIsWhitelisted() public {
        vm.prank(MANAGER);
        whitelistCostPolicy.addWhitelist(ALICE);
        assertEq(whitelistCostPolicy.calculateCost(ALICE, MIN_USER_COUNT + 1, 100, 0), 0);
    }

    function test_CalculateCost_WhenUserIsRemovedFromWhitelist() public {
        vm.prank(MANAGER);
        whitelistCostPolicy.removeWhitelist(ALICE);
        assertEq(whitelistCostPolicy.calculateCost(ALICE, MIN_USER_COUNT + 1, 100, 0), whitelistCostPolicy.oneTimeFee());
    }

    function test_RevertWhen_AddWhitelist_NotByOwner() public {
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, address(this)));
        whitelistCostPolicy.addWhitelist(ALICE);
    }

    function test_AddWhitelist_UpdatesWhitelist() public {
        vm.prank(MANAGER);
        whitelistCostPolicy.addWhitelist(ALICE);
        assertTrue(whitelistCostPolicy.whitelist(ALICE));
    }

    function test_RevertWhen_RemoveWhitelist_NotByOwner() public {
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, address(this)));
        whitelistCostPolicy.removeWhitelist(ALICE);
    }

    function test_RemoveWhitelist_UpdatesWhitelist() public {
        vm.startPrank(MANAGER);
        whitelistCostPolicy.addWhitelist(ALICE);
        whitelistCostPolicy.removeWhitelist(ALICE);
        vm.stopPrank();
        assertFalse(whitelistCostPolicy.whitelist(ALICE));
    }
}
