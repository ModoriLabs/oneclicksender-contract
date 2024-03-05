// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import { ICostPolicyV2 } from "./interfaces/ICostPolicyV2.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {ICostPolicy} from "./interfaces/ICostPolicy.sol";

contract WhitelistCostPolicy is ICostPolicyV2, Ownable2Step {
    uint256 public oneTimeFee;
    uint256 public perUserFee;
    uint256 public maxFreeUserCount;
    mapping (address => bool) public whitelist;

    event OneTimeFeeUpdated(uint256 _oneTimeFee);
    event PerUserFeeUpdated(uint256 _perUserFee);
    event MaxFreeUserCountUpdated(uint256 _maxFreeUserCount);
    event WhitelistUpdated(address user, bool status);

    constructor(
        address initialOwner,
        uint256 _oneTimeFee,
        uint256 _perUserFee,
        uint256 _minUserCount
    ) Ownable(initialOwner) {
        oneTimeFee = _oneTimeFee;
        perUserFee = _perUserFee;
        maxFreeUserCount = _minUserCount;
    }

    /// @param token token to send. Use address(0) for ETH
    function calculateCost(
        address token,
        address sender,
        uint256 userCount,
        uint256 totalAmount,
        uint256 typeId
    )
        external
        view
        returns (uint256 cost)
    {
        if (userCount <= maxFreeUserCount) {
            return 0;
        }

        if (whitelist[sender]) {
            return 0;
        }

        if (typeId == 0) {
            cost = oneTimeFee;
        } else if (typeId == 1) {
            cost = perUserFee * userCount;
        } else {
            revert("Invalid typeId");
        }
    }

    function setOneTimeFee(uint256 _oneTimeFee) external onlyOwner {
        oneTimeFee = _oneTimeFee;
        emit OneTimeFeeUpdated(_oneTimeFee);
    }

    function setPerUserFee(uint256 _perUserFee) external onlyOwner {
        perUserFee = _perUserFee;
        emit PerUserFeeUpdated(_perUserFee);
    }

    function setMaxFreeUserCount(uint256 _maxFreeUserCount) external onlyOwner {
        maxFreeUserCount = _maxFreeUserCount;
        emit MaxFreeUserCountUpdated(_maxFreeUserCount);
    }

    function addWhitelist(address user) external onlyOwner {
        whitelist[user] = true;
        emit WhitelistUpdated(user, true);
    }

    function removeWhitelist(address user) external onlyOwner {
        whitelist[user] = false;
        emit WhitelistUpdated(user, false);
    }
}
