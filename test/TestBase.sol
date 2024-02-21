// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import { PRBTest } from "@prb/test/PRBTest.sol";
import { console2 } from "forge-std/console2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";

import { ERC1967Proxy } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import { ERC20BatchSender } from "src/ERC20BatchSender.sol";
import { BasicCostPolicy, ICostPolicy } from "src/BasicCostPolicy.sol";
import { MockERC20 } from "src/test/MockERC20.sol";
import { WhitelistCostPolicy} from "src/WhitelistCostPolicy.sol";

contract TestBase is PRBTest, StdCheats {
    ERC20BatchSender internal batchSender;
    BasicCostPolicy internal costPolicy;
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

        costPolicy = new BasicCostPolicy(MANAGER, 100, 10, MIN_USER_COUNT);
        whitelistCostPolicy = new WhitelistCostPolicy(MANAGER, 100, 10, MIN_USER_COUNT);
        ERC20BatchSender batchSenderImpl = new ERC20BatchSender();
        batchSender = ERC20BatchSender(address(new ERC1967Proxy(address(batchSenderImpl), "")));
        batchSender.initialize(MANAGER, ICostPolicy(costPolicy), FEE_RECIPIENT);
    }
}
