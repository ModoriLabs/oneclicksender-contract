// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { UpgradeableBase } from "./UpgradeableBase.sol";
import { ICostPolicyV2 } from "./interfaces/ICostPolicyV2.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract ERC20BatchSenderV2 is UpgradeableBase {
    address constant ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    ICostPolicyV2 public costPolicy;
    address public feeRecipient;

    using SafeERC20 for IERC20;

    error InsufficientCost();
    error LengthMismatch();
    error InvalidTotalAmount(uint256 actual, uint256 expected);

    event BatchSend(address indexed token, address[] accounts, uint256[] amounts, uint256 typeId);
    event ERC20TokenWithdrawn(IERC20 _token, address _recipient, uint256 _value);
    event CostPolicyUpdated(ICostPolicyV2 _costPolicy);
    event FeeRecipientUpdated(address _feeRecipient);

    constructor() {
        _disableInitializers();
    }

    function initialize(address manager, ICostPolicyV2 _costPolicy, address _feeRecipient) public initializer {
        __UpgradeableBase_init(_msgSender());
        _grantManagerRole(manager);
        costPolicy = _costPolicy;
        feeRecipient = _feeRecipient;
    }

    function reinitialize(ICostPolicyV2 _costPolicy, address _feeRecipient) public reinitializer(3) {
        costPolicy = _costPolicy;
        feeRecipient = _feeRecipient;
    }

    /// @notice send
    /// @dev    suppose token is approved.
    function send(
        IERC20 _token,
        address[] calldata _accounts,
        uint256[] calldata _amounts,
        uint256 _totalAmount,
        uint256 _typeId
    )
        external
        payable
    {
        if (_accounts.length != _amounts.length) {
            revert LengthMismatch();
        }

        uint256 cost =
            costPolicy.calculateCost(address(_token), _msgSender(), _accounts.length, _amounts.length, _typeId);
        if (msg.value < cost) {
            revert InsufficientCost();
        }
        _checkTotalAmount(_amounts, _totalAmount);

        _sendFee(cost);
        _token.safeTransferFrom(_msgSender(), address(this), _totalAmount);
        _send(_token, _accounts, _amounts, _typeId);
    }

    function sendETH(
        address[] calldata _accounts,
        uint256[] calldata _amounts,
        uint256 _totalAmount,
        uint256 _typeId
    )
        public
        payable
    {
        if (_accounts.length != _amounts.length) {
            revert LengthMismatch();
        }

        uint256 cost = costPolicy.calculateCost(ETH_ADDRESS, _msgSender(), _accounts.length, _amounts.length, _typeId);
        if (msg.value < _totalAmount + cost) {
            revert InsufficientCost();
        }
        _checkTotalAmount(_amounts, _totalAmount);

        _sendFee(cost);
        _sendETH(_accounts, _amounts, _typeId);
    }

    function _send(IERC20 _token, address[] calldata _accounts, uint256[] calldata _amounts, uint256 _typeId) private {
        for (uint256 i = 0; i < _accounts.length; i++) {
            address account = _accounts[i];
            uint256 amount = _amounts[i];
            _token.safeTransfer(account, amount);
        }

        emit BatchSend(address(_token), _accounts, _amounts, _typeId);
    }

    function _sendETH(address[] calldata _accounts, uint256[] calldata _amounts, uint256 _typeId) private {
        for (uint256 i = 0; i < _accounts.length; i++) {
            address account = _accounts[i];
            uint256 amount = _amounts[i];
            (bool success,) = account.call{ value: amount }("");
            require(success, "Transfer failed.");
        }

        emit BatchSend(ETH_ADDRESS, _accounts, _amounts, _typeId);
    }

    function _sendFee(uint256 amount) internal {
        (bool success,) = feeRecipient.call{ value: amount }("");
        require(success, "Transfer failed.");
    }

    /**
     * Allows the owner of the contract to withdraw ETH that may reside on the contract address.
     */
    function withdrawETH(address _recipient) public onlyManager returns (bool success) {
        (bool sent,) = payable(_recipient).call{ value: address(this).balance }("");
        require(sent, "Failed to send Ether");
        return true;
    }

    /**
     * Allows the owner of the contract to withdraw any ERC20 that may reside on the contract address.
     */
    function withdrawERC20(
        IERC20 _token,
        address _recipient,
        uint256 _value
    )
        public
        onlyManager
        returns (bool success)
    {
        IERC20 token = IERC20(_token);
        token.safeTransfer(_recipient, _value);

        emit ERC20TokenWithdrawn(_token, _recipient, _value);
        return true;
    }

    function setFeeRecipient(address _feeRecipient) public onlyManager {
        feeRecipient = _feeRecipient;
        emit FeeRecipientUpdated(_feeRecipient);
    }

    function setCostPolicy(ICostPolicyV2 _costPolicy) public onlyManager {
        costPolicy = _costPolicy;
        emit CostPolicyUpdated(_costPolicy);
    }

    function _checkTotalAmount(uint256[] calldata _amounts, uint256 _totalAmount) internal pure {
        uint256 sumAmount = 0;
        for (uint256 i = 0; i < _amounts.length; i++) {
            sumAmount += _amounts[i];
        }
        if (sumAmount != _totalAmount) {
            revert InvalidTotalAmount(sumAmount, _totalAmount);
        }
    }
}
