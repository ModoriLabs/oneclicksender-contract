// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "./TestBase.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ForkE2ETest is TestBase {
    uint256 internal cypressFork;
    address internal richUser;

    function setUp() public override {
        cypressFork = vm.createFork(vm.envString("CYPRESS_RPC_URL"));
        vm.selectFork(cypressFork);
        batchSender = ERC20BatchSenderV2(0xe1bFB3d11890f9b11C046CdEC9f7E7cD7D472238);
        whitelistCostPolicy = WhitelistCostPolicy(0x0dA42C1F37d1C138361f0e3F1743065dC0399975);
        MANAGER = address(0xCf638706ce117C3DBcAd607a133449551965F162);
        token = MockERC20(0xceE8FAF64bB97a73bb51E115Aa89C17FfA8dD167); // oUSDT
        richUser = address(0xfAeeC9B2623b66BBB3545cA24cFc32A8504fcF1B);
    }

    function test_Send200_IsFree_IfTheUserIsInTheWhitelist() external {
        vm.prank(MANAGER);
        whitelistCostPolicy.addWhitelist(address(this));

        uint256 balanceBefore = batchSender.feeRecipient().balance;
        _send200WithoutFaucet();
        uint256 balanceAfter = batchSender.feeRecipient().balance;

        assertEq(balanceBefore, balanceAfter);
        assertEq(token.balanceOf(address(10_000)), 0);
        assertEq(token.balanceOf(address(10_001)), 100);
        assertEq(token.balanceOf(address(10_199)), 19_900);
    }

    function test_Send200_TakesFee_IfTheUserIsNotInTheWhitelist() external {
        vm.prank(MANAGER);
        whitelistCostPolicy.removeWhitelist(address(this));

        uint256 balanceBefore = batchSender.feeRecipient().balance;
        _send200WithoutFaucet();
        uint256 balanceAfter = batchSender.feeRecipient().balance;

        assertEq(balanceAfter, balanceBefore + whitelistCostPolicy.oneTimeFee());
        assertEq(token.balanceOf(address(10_000)), 0);
        assertEq(token.balanceOf(address(10_001)), 100);
        assertEq(token.balanceOf(address(10_199)), 19_900);
    }

    // same as _send200
    function _send200WithoutFaucet() internal {
        uint256 cost = whitelistCostPolicy.oneTimeFee();
        uint256 total = 1_990_000;
        vm.prank(richUser);
        token.transfer(address(this), total);

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
}
