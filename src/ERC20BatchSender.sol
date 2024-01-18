// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { UpgradeableBase } from "./UpgradeableBase.sol";
import { ICostPolicy } from "./interfaces/ICostPolicy.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract ERC20BatchSender is UpgradeableBase {
    address constant ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    ICostPolicy public costPolicy;

    using SafeERC20 for IERC20;

    error InsufficientCost();
    error LengthMismatch();

    event BatchSend(address indexed token, address[] accounts, uint256[] amounts, uint256 typeId);
    event ERC20TokenWithdrawn(IERC20 _token, address _recipient, uint256 _value);

    constructor() {
        _disableInitializers();
    }

    function initialize(address manager, ICostPolicy _costPolicy) public initializer {
        __UpgradeableBase_init(_msgSender());
        _grantManagerRole(manager);
        costPolicy = _costPolicy;
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

        uint256 cost = costPolicy.calculateCost(address(_token), _accounts.length, _amounts.length, _typeId);
        if (msg.value < cost) {
            revert InsufficientCost();
        }

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

        uint256 cost = costPolicy.calculateCost(ETH_ADDRESS, _accounts.length, _amounts.length, _typeId);
        if (msg.value < _totalAmount + cost) {
            revert InsufficientCost();
        }
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

    function _sendETH(address[] calldata _accounts, uint256[] calldata _amounts, uint256 _typeId) public payable {
        for (uint256 i = 0; i < _accounts.length; i++) {
            address account = _accounts[i];
            uint256 amount = _amounts[i];
            (bool success,) = account.call{ value: amount }("");
            require(success, "Transfer failed.");
        }

        emit BatchSend(ETH_ADDRESS, _accounts, _amounts, _typeId);
    }

    /**
     * Allows the owner of the contract to withdraw any funds that may reside on the contract address.
     *
     */
    function withdrawETH(address _recipient) public onlyManager returns (bool success) {
        (bool sent,) = payable(_recipient).call{ value: address(this).balance }("");
        require(sent, "Failed to send Ether");
        return true;
    }

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
}
