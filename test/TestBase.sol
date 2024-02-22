// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import { PRBTest } from "@prb/test/PRBTest.sol";
import { console2 } from "forge-std/console2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";

import { ERC1967Proxy } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import { ERC20BatchSenderV2 } from "src/ERC20BatchSenderV2.sol";
import { BasicCostPolicy } from "src/BasicCostPolicy.sol";
import { ICostPolicyV2 } from "src/interfaces/ICostPolicyV2.sol";
import { WhitelistCostPolicy} from "src/WhitelistCostPolicy.sol";
import { MockERC20 } from "src/test/MockERC20.sol";

contract TestBase is PRBTest, StdCheats {
    ERC20BatchSenderV2 internal batchSender;
    BasicCostPolicy internal basicCostPolicy;
    WhitelistCostPolicy internal whitelistCostPolicy;
    MockERC20 internal token;

    address internal MANAGER = address(1);
    address internal ALICE = address(2);
    address internal BOB = address(3);
    address internal FEE_RECIPIENT = address(4);
    uint256 internal MIN_USER_COUNT = 10;

    /// @dev A function invoked before each test case is run.
    function setUp() public virtual {
        uint8 decimals = 18;
        token = new MockERC20("TEST ERC20", "TEST", decimals);

        basicCostPolicy = new BasicCostPolicy(MANAGER, 100, 10, MIN_USER_COUNT);
        whitelistCostPolicy = new WhitelistCostPolicy(MANAGER, 100, 10, MIN_USER_COUNT);
        ERC20BatchSenderV2 batchSenderImpl = new ERC20BatchSenderV2();
        batchSender = ERC20BatchSenderV2(address(new ERC1967Proxy(address(batchSenderImpl), "")));

        // use whitelistCostPolicy
        batchSender.initialize(MANAGER, ICostPolicyV2(whitelistCostPolicy), FEE_RECIPIENT);
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

    function _faucet(address _recipient, uint256 _amount) internal {
        token.mint(_recipient, _amount);
    }
}
