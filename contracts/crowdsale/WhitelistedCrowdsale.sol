pragma solidity ^0.4.18;

import "../math/SafeMath.sol";
import "./CappedCrowdsale.sol";


/**
 * @title WhitelistedCrowdsale
 * @dev Extension of Crowdsale to limit participation to whitelisted addresses.
 */
contract WhitelistedCrowdsale is CappedCrowdsale {
  using SafeMath for uint256;

  bool public sealed;

  mapping(address => bool) public whitelist;

  event Whitelisted(address indexed addr);

  // Add to whitelist
  function add(address addr) public onlyOwner {
      require(!sealed);
      require(addr != 0x0);
      whitelist[addr] = true;
      Whitelisted(addr;
  }

  // Add batch to whitelist
  function multiAdd(address[] addresses, uint[] max) public onlyOwner {
      require(!sealed);
      require(addresses.length != 0);
      require(addresses.length == max.length);
      for (uint i = 0; i < addresses.length; i++) {
          require(addresses[i] != 0x0);
          whitelist[addresses[i]] = max[i];
          Whitelisted(addresses[i], max[i]);
      }
  }

  // After sealing, no more whitelisting is possible
  function seal() public onlyOwner {
      require(!sealed);
      sealed = true;
  }

  // Override low level token purchase function to send data to validPurchase()
  function buyTokens(address beneficiary) public payable {
    require(beneficiary != address(0));
    require(validPurchase(beneficiary));

    uint256 weiAmount = msg.value;

    // calculate token amount to be created
    uint256 tokens = getTokenAmount(weiAmount);

    // update state
    weiRaised = weiRaised.add(weiAmount);

    token.mint(beneficiary, tokens);
    TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);

    forwardFunds();
  }

  // overriding Crowdsale#validPurchase to add extra whitelist logic
  // @return true if investors can buy at the moment
  function validPurchase(address _beneficiary) internal view returns (bool) {
    bool whitelisted = whitelist[_beneficiary];
    return whitelisted && super.validPurchase();
  }

}
