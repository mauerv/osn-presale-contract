pragma solidity ^0.4.18;

import "./WhitelistedCrowdsale.sol";

/**
 * @title SampleCrowdsale
 * @dev This is an example of a fully fledged crowdsale.
 * The way to add new features to a base crowdsale is by multiple inheritance.
 * In this example we are providing following extensions:
 * CappedCrowdsale - sets a max boundary for raised funds
 * RefundableCrowdsale - set a min goal to be reached and returns funds if it's not met
 *
 * After adding multiple features it's good practice to run integration tests
 * to ensure that subcontracts works together as intended.
 */
contract OSNPresaleCrowdsale is WhitelistedCrowdsale {

  function OSNPresaleCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, uint256 _cap, address _wallet, MintableToken _token) public
    CappedCrowdsale(_cap)
    Crowdsale(_startTime, _endTime, _rate, _wallet, _token)
  {

  }
}
