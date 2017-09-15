pragma solidity ^0.4.4;

import "./ConvertLib.sol";

contract exchangeShop {
	uint 	desiredCurrencyRate;
	address Recipient;
	uint 	convertedRemittableAmount;
	bytes32 hashEmailedPassword;
	bytes32 hashWhisperedPassword;
	bytes32 hashPasswordsPair;
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
	function remittanceTokenConstructor(address recipient, bytes32 hashEmailedPassword, bytes32 hashWhisperedPassword)
	returns(bool success)
	 {
        hashPasswordsPair = keccak256(hashEmailedPassword, hashWhisperedPassword);
		tokens[recipient].recipient = recipient;
        tokens[recipient].hashPasswordsPair = hashPasswordsPair;
		tokenIndex.push(recipient);
		return true;
    }
	
function exchange(uint desiredCurrencyRate)
returns(bool success)
	{
		convertedRemittableAmount = ConvertLib.convert(msg.value, desiredCurrencyRate);
		Recipient.transfer(convertedRemittableAmount);
	}

function authenticateRemittance(address recipient, bytes32 hashPasswordsPair)
returns(bool success)
	 {
        hashPasswordsPair = tokens[recipient].hashPasswordsPair;
		remittanceContract.transfer(hashPasswordsPair);
	}

function die()
    {
        require(msg.sender == Owner);
        selfdestruct(Owner);
    }
}