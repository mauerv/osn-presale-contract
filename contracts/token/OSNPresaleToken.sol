pragma solidity ^0.4.18;

import "./StandardToken.sol";


/**
 * @title OSNPresaleToken
 * @dev Very simple ERC20 Token to use as the initial OSN token.
 */
contract OSNPresaleToken is StandardToken {

  string public constant name = "OSNPresaleToken"; // solium-disable-line uppercase
  string public constant symbol = "OSNP"; // solium-disable-line uppercase
  uint8 public constant decimals = 18; // solium-disable-line uppercase

  uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(decimals));

  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  function SimpleToken() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
    Transfer(0x0, msg.sender, INITIAL_SUPPLY);
  }

}
