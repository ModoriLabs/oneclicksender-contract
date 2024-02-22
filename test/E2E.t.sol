// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "./TestBase.sol";

contract E2ETest is TestBase {
    function setUp() public override {
        super.setUp();
    }

    function test_Send200_IsFree_IfTheUserIsInTheWhitelist() external {
        uint256 cost = whitelistCostPolicy.oneTimeFee();
        vm.prank(MANAGER);
        whitelistCostPolicy.addWhitelist(address(this));

        _send200();

        assertEq(FEE_RECIPIENT.balance, 0);
        assertEq(token.balanceOf(address(10_000)), 0);
        assertEq(token.balanceOf(address(10_001)), 100);
        assertEq(token.balanceOf(address(10_199)), 19900);
    }

    function test_Send200_TakesFee_IfTheUserIsNotInTheWhitelist() external {
        uint256 cost = whitelistCostPolicy.oneTimeFee();
        vm.prank(MANAGER);
        whitelistCostPolicy.removeWhitelist(address(this));

        _send200();

        assertEq(FEE_RECIPIENT.balance, whitelistCostPolicy.oneTimeFee());
        assertEq(token.balanceOf(address(10_000)), 0);
        assertEq(token.balanceOf(address(10_001)), 100);
        assertEq(token.balanceOf(address(10_199)), 19900);
    }
}
