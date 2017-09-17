pragma solidity ^0.4.4;

import "./ConvertLib.sol";
import "./Remittance.sol";

contract exchangeShop {
	uint 	desiredCurrencyRate;
	address recipient;
	uint 	convertedRemittableAmount;
	bytes32 hashEmailedPassword;
	bytes32 hashWhisperedPassword;
	bytes32 HashPasswordPair;
	address remittanceContract;
	address Owner;

function exchangeShop(address _remittanceContract) {
		Owner = msg.sender;
		remittanceContract = _remittanceContract;
		desiredCurrencyRate = 265;
	}

	struct RemittanceToken {
		address recipient;
		bytes32 hashPasswordsPair;
    }

    modifier ownerOnly() {
        require(msg.sender == Owner);
        _;
    }

	mapping(address => RemittanceToken) tokens;
	address[] tokenIndex;

	
function exchange(uint desiredCurrencyRate)
returns(bool success)
	{
		convertedRemittableAmount = ConvertLib.convert(msg.value, desiredCurrencyRate);
		recipient.transfer(convertedRemittableAmount);
	}

  remittance RemAuth;
  function myContract(address _addressRemittance) {
    RemAuth = Remittance(_addressRemittance);
  }
  function remittanceAuth() {
    recipient = tokens[recipient].recipient;
	RemAuth.tokenAuthenticator(recipient, HashPasswordPair);
  }	

function die()
    {
        require(msg.sender == Owner);
        selfdestruct(Owner);
    }
}