// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "./TestBase.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract ERC20BatchTransferTest is TestBase {
    /// @dev A function invoked before each test case is run.
    function setUp() public override {
        super.setUp();
    }

    /*
    function testUpgradeToAndCall() external {
        ERC20BatchSender newImpl = new ERC20BatchSender();
        batchSender.upgradeToAndCall(
            address(newImpl), abi.encodeWithSignature("initialize(address,address)", MANAGER, whitelistCostPolicy)
        );
    }
    */

    function test_RevertWhen_Send_GivenDifferentAccountsAndAmountsLength() external { }

    function test_RevertWhen_Send_WithInsufficientCost() external {
        address[] memory recipients = new address[](11);
        for (uint256 i = 0; i < 11; i++) {
            recipients[i] = address(uint160(10_000 + i));
        }

        uint256[] memory amounts = new uint256[](11);
        for (uint256 i = 0; i < 11; i++) {
            amounts[0] = 100;
        }

        uint256 typeId = 0;
        vm.expectRevert(abi.encodeWithSignature("InsufficientCost()"));
        batchSender.send{ value: 1 }(token, recipients, amounts, 1100, typeId);
    }

    function test_SendOneUser() external {
        uint256 cost = whitelistCostPolicy.oneTimeFee();
        uint256 total = 300;
        _faucet(address(this), 1000);
        deal(address(this), cost);

        token.approve(address(batchSender), type(uint256).max);

        address[] memory recipients = new address[](1);
        recipients[0] = ALICE;

        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 100;

        uint256 typeId = 0;
        batchSender.send{ value: cost }(token, recipients, amounts, total, typeId);
    }

    function test_Send() external {
        uint256 cost = whitelistCostPolicy.oneTimeFee();
        uint256 total = 300;
        _faucet(address(this), 1000);
        deal(address(this), cost);

        token.approve(address(batchSender), type(uint256).max);

        address[] memory recipients = new address[](2);
        recipients[0] = ALICE;
        recipients[1] = BOB;

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 100;
        amounts[1] = 200;

        uint256 typeId = 0;
        batchSender.send{ value: cost }(token, recipients, amounts, total, typeId);
    }

    function test_Send200_ReceiveFee() external {
        uint256 cost = whitelistCostPolicy.oneTimeFee();
        _send200();
        assertEq(FEE_RECIPIENT.balance, cost);
    }

    function test_RevertWhen_SendETH_GivenDifferentAccountsAndAmountsLength() external { }

    function test_RevertWhen_SendETH_WithInsufficientTotalETH() external { }

    function test_SendETH() external {
        deal(address(this), 100);
        // TODO:
        // batchSender.sendETH { value:  } ();
    }

    function test_RevertWhen_Withdraw_ByNonManager() external {
        vm.expectRevert(abi.encodeWithSignature("NotManager()"));
        batchSender.withdrawETH(address(this));
    }

    // TODO
    // typeId 0 -> oneTimeFee
    // typeId 1 -> perUserFee

    function test_Withdraw() external {
        deal(address(batchSender), 100);
        vm.prank(MANAGER);
        batchSender.withdrawETH(ALICE);
        assertEq(ALICE.balance, 100);
    }

    function test_RevertWhen_WithdrawERC20() external {
        vm.expectRevert(abi.encodeWithSignature("NotManager()"));
        batchSender.withdrawERC20(token, address(this), 100);
    }

    function test_WithdrawERC20() external {
        token.mint(address(batchSender), 1000);

        vm.prank(MANAGER);
        batchSender.withdrawERC20(token, address(this), 100);
        assertEq(token.balanceOf(address(this)), 100);
    }

    function _send200() internal {
        uint256 cost = whitelistCostPolicy.oneTimeFee();
        uint256 total = 1_990_000;
        _faucet(address(this), total);
        deal(address(this), cost);

        token.approve(address(batchSender), type(uint256).max);

        address[] memory recipients = new address[](200);
        for (uint256 i = 0; i < 200; i++) {
            recipients[i] = address(uint160(10_000 + i));
        }

        uint256[] memory amounts = new uint256[](200);
        for (uint256 i = 0; i < 200; i++) {
            amounts[i] = i * 100;
        }

        uint256 typeId = 0;
        batchSender.send{ value: cost }(token, recipients, amounts, total, typeId);
    }

    function _faucet(address _recipient, uint256 _amount) private {
        token.mint(_recipient, _amount);
    }
}
