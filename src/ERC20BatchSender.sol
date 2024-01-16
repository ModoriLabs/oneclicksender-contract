// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import { UpgradeableBase } from "./UpgradeableBase.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20BatchSender is UpgradeableBase  {
    uint256 public constant COST = 0.0001 ether; // FIXME: 0.0001 is for testnet only

    error InsufficientCost();

    event BatchSend(
        address indexed token,
        address[] accounts,
        uint256[] amounts
    );

    event ERC20TokenWithdrawn(
        IERC20 _token,
        address _recipient,
        uint256 _value
    );

    constructor() {
        _disableInitializers();
    }

    function initialize(
        address manager
    ) public initializer {
        __UpgradeableBase_init(_msgSender());
        _grantManagerRole(manager);
    }

    /// @notice send
    /// @dev    suppose token is approved.
    function send(IERC20 _token, address[] memory _accounts, uint256[] memory _amounts) public payable {
        if (msg.value < COST) {
            revert InsufficientCost();
        }
        _send(_token, _accounts, _amounts);
    }

    function _send(IERC20 _token, address[] memory _accounts, uint256[] memory _amounts) private {
        for (uint256 i = 0; i < _accounts.length; i++) {
            address account = _accounts[i];
            uint256 amount = _amounts[i];
            _token.transferFrom(_msgSender(), account, amount);
        }

        emit BatchSend(address(_token), _accounts, _amounts);
    }

    /**
      * Allows the owner of the contract to withdraw any funds that may reside on the contract address.
      * */
    function withdrawFunds(address _recipient) public onlyManager returns(bool success) {
        (bool sent, ) = payable(_recipient).call { value: address(this).balance }("");
        require (sent, "Failed to send Ether");
        return true;
    }

    function withdrawERC20Token(IERC20 _token,  address _recipient, uint256 _value) public onlyManager returns(bool success) {
        IERC20 token = IERC20(_token);
        token.transfer(_recipient, _value);

        emit ERC20TokenWithdrawn(_token, _recipient, _value);
        return true;
    }
}
