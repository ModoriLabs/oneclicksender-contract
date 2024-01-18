// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import { ICostPolicy } from "./interfaces/ICostPolicy.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";

contract BasicCostPolicy is ICostPolicy, Ownable2Step {
    uint256 public oneTimeFee;
    uint256 public perUserFee;

    event OneTimeFeeUpdated(uint256 _oneTimeFee);
    event PerUserFeeUpdated(uint256 _perUserFee);

    constructor(address initialOwner, uint256 _oneTimeFee, uint256 _perUserFee) Ownable(initialOwner) {
        oneTimeFee = _oneTimeFee;
        perUserFee = _perUserFee;
    }

    function calculateCost(
        address sender,
        uint256 userCount,
        uint256 totalAmount,
        uint256 typeId
    )
        external
        view
        returns (uint256 cost)
    {
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
}
