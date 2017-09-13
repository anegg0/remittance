pragma solidity ^0.4.4;

import "./ConvertLib.sol";

contract ExchangeShop {
	uint 	desiredCurrencyRate;
	bytes32 EmailedPassword;
	bytes32 WhisperedPassword;
	address Recipient;
	uint 	convertedRemittableAmount;
	bytes32 hashedEmailedPassword;
	bytes32 hashedWhisperedPassword;
	address remittanceContract;
	address Owner;
	bytes32 passwordToSend;

function ExchangeShop() {
		Owner = msg.sender;
	}

function ExchangeShop(address _remittanceContract) {
		Owner = msg.sender;
		remittanceContract = _remittanceContract;
		desiredCurrencyRate = 265;
	}

	struct RemittanceToken {
		address recipient;
		bytes32 emailedPwd;
		bytes32 whisperedPwd;
    }

    modifier ownerOnly() {
        require(msg.sender == Owner);
        _;
    }

	mapping(address => RemittanceToken) Tokens;
	address[] tokenIndex;
	function RemittanceTokenConstructor(address recipient, bytes32 emailedPassword, bytes32 whisperedPassword)
	returns(bool success)
	 {
		emailedPassword = keccak256(emailedPassword);
		whisperedPassword = keccak256(whisperedPassword);
        Tokens[recipient].recipient = recipient;
        Tokens[recipient].emailedPwd = emailedPassword;
        Tokens[recipient].whisperedPwd = whisperedPassword;
		tokenIndex.push(recipient);
		return true;
    }
	
function exchange(uint desiredCurrencyRate)
returns(bool success)
	{
		convertedRemittableAmount = ConvertLib.convert(msg.value,desiredCurrencyRate);
		Recipient.transfer(convertedRemittableAmount);
	}

function AuthenticateRemittance(address recipient)
returns(bool success)
	 {
		remittanceContract.transfer(Tokens[recipient]);
	}

function die()
    {
        require(msg.sender == Owner);
        suicide(Owner);
    }
}