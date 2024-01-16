// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import { PRBTest } from "@prb/test/PRBTest.sol";
import { console2 } from "forge-std/console2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";

import { ERC1967Proxy } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import { ERC20BatchSender } from "src/ERC20BatchSender.sol";
import { MockERC20 } from "src/test/MockERC20.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract ERC20BatchTransferTest is PRBTest, StdCheats {
    ERC20BatchSender internal batchSender;
    MockERC20 internal token;

    address internal MANAGER = address(1);
    address internal ALICE = address(2);
    address internal BOB = address(3);

    /// @dev A function invoked before each test case is run.
    function setUp() public virtual {
        uint8 decimals = 18;
        token = new MockERC20("TEST ERC20", "TEST", decimals);

        ERC20BatchSender batchSenderImpl = new ERC20BatchSender();
        batchSender = ERC20BatchSender(address(new ERC1967Proxy(address(batchSenderImpl), "")));
        batchSender.initialize(MANAGER);
    }

    function test_RevertWhen_Send_WithInsufficientCost() external {
    }

    function test_Send() external {
        uint256 cost = batchSender.COST();
        _faucet(address(this), 1000);
        deal(address(this), cost);

        token.approve(address(batchSender), type(uint256).max);

        address[] memory recipients = new address[](2);
        recipients[0] = ALICE;
        recipients[1] = BOB;

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 100;
        amounts[1] = 200;

        batchSender.send { value: cost }(token, recipients, amounts);
    }

    function test_RevertWhen_Withdraw_ByNonManager() external {

    }

    function test_RevertWhen_WithdrawERC20Token() external {

    }

    function _faucet(address _recipient, uint256 _amount) private {
        token.mint(_recipient, _amount);
    }
}
