pragma solidity ^0.4.4;

import "./ExchangeShop.sol";

contract Remittance {
		address Owner;
		address sender;
		bytes32 hashPasswordPair;
		bytes transactionData;
		int remittableAmount;
		address recipient;

        event LogTokenAuthentication(address recipient, bool success);
        event RemittanceTokenCreation(address recipient, uint remittableAmount);

	function Remittance() {
		Owner = msg.sender;
	}

	struct RemittanceToken {
		address recipient;
		uint remittableAmount;
		bytes32 lock;
		address authorizedExchange;
		uint desiredCurrencyRate;
    }

    modifier ownerOnly() {
        require(msg.sender == Owner);
        _;
    }

	mapping(address => RemittanceToken) tokens;
	address[] tokenIndex;
	function remittanceTokenBuilder(address authorizedExchange, address recipient, uint remittableAmount, uint desiredCurrencyRate)
	returns(bool success)
	 {
		//hashPasswordPair is a hash of the Emailed Password and the password that has been given in person 
        tokens[recipient].recipient = recipient;
		tokens[recipient].authorizedExchange = authorizedExchange;
		tokens[recipient].desiredCurrencyRate = desiredCurrencyRate;
		tokens[recipient].remittableAmount = remittableAmount;
        tokens[recipient].lock = hashPasswordPair;
		tokenIndex.push(recipient);
	    RemittanceTokenCreation(recipient, remittableAmount);
		return true;
    }

	function tokenAuthenticator(address recipient, bytes32 sentHashPasswordPair)
	external
	ownerOnly()
	returns(bool success)
	{
		sender = msg.sender; 
		require(recipient == sender);
		if (sentHashPasswordPair == tokens[recipient].lock && msg.sender == tokens[recipient].authorizedExchange)
		sender.transfer(tokens[recipient].remittableAmount);
		return true;
		LogTokenAuthentication(sender, success);
		}

exchangeShop Exch;
  function myContract(address _addressExchangeShop) {
    Exch = exchangeShop(_addressExchangeShop);
  }
  function remittanceExch() {
    Exch.exchange();
  }

	function die() {
        require(msg.sender == Owner);
        selfdestruct(Owner);
    }
}		