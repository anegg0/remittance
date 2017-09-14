pragma solidity ^0.4.4;

import "./ConvertLib.sol";

contract ExchangeShop {
	uint 	desiredCurrencyRate;
	address Recipient;
	uint 	convertedRemittableAmount;
	uint256 hashEmailedPassword;
	uint256 hashWhisperedPassword;
	address remittanceContract;
	address Owner;

function ExchangeShop(address _remittanceContract) {
		Owner = msg.sender;
		remittanceContract = _remittanceContract;
		desiredCurrencyRate = 265;
	}

	struct RemittanceToken {
		address recipient;
		uint256 hashPasswordsPair;
    }

    modifier ownerOnly() {
        require(msg.sender == Owner);
        _;
    }

	mapping(address => RemittanceToken) tokens;
	address[] tokenIndex;
	function RemittanceTokenConstructor(address recipient, uint256 hashEmailedPassword, uint256 hashWhisperedPassword)
	returns(bool success)
	 {
        tokens[recipient].recipient = recipient;
        tokens[recipient].hashPasswordsPair = keccak256(hashEmailedPassword,hashWhisperedPassword);
		tokenIndex.push(recipient);
		return true;
    }
	
function exchange(uint desiredCurrencyRate)
returns(bool success)
	{
		convertedRemittableAmount = ConvertLib.convert(msg.value, desiredCurrencyRate);
		Recipient.transfer(convertedRemittableAmount);
	}

function AuthenticateRemittance(address recipient, uint256 hashPasswordsPair)
returns(bool success)
	 {
        hashPasswordsPair = tokens[recipient].hashPasswordsPair;
		remittanceContract.transfer(hashPasswordsPair);
	}

function die()
    {
        require(msg.sender == Owner);
        suicide(Owner);
    }
}