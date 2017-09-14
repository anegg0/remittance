pragma solidity ^0.4.4;

contract Remittance {
		address Owner;
		address sender;
		address exchange;
		bytes32 hashEmailedPassword;
		bytes32 hashWhisperedPassword;
		bytes32 hashPasswordsPair;
		bytes32 SentPasswords;
		bytes transactionData;

        event LogTokenAuthentication(address recipient, bool success);
        event RemittanceTokenCreation(address recipient, uint remittableAmount);

	function Remittance() {
		Owner = msg.sender;
	}

	struct RemittanceToken {
		address recipient;
		uint remittableAmount;
		bytes32 hashPasswordsPair;
    }

    modifier ownerOnly() {
        require(msg.sender == Owner);
        _;
    }

	mapping(address => RemittanceToken) tokens;
	address[] tokenIndex;
	function RemittanceTokenConstructor(address recipient, uint remittableAmount, bytes32 hashEmailedPassword, bytes32 hashWhisperedPassword)
	returns(bool success)
	 {
        tokens[recipient].recipient = recipient;
		tokens[recipient].remittableAmount = remittableAmount;
        tokens[recipient].hashPasswordsPair = keccak256(hashEmailedPassword, hashWhisperedPassword);
		tokenIndex.push(recipient);
	    RemittanceTokenCreation(recipient, remittableAmount);
		return true;
    }

	function TokenAuthenticator(address recipient, bytes32 hashPasswordsPair)
	external
	ownerOnly()
	returns(bool success)
	{
		sender = msg.sender;
		require(recipient == sender);
		SentPasswords = hashPasswordsPair;
		if(hashPasswordsPair == tokens[recipient].hashPasswordsPair) 
		sender.transfer(tokens[recipient].remittableAmount);
		return true;
		LogTokenAuthentication(sender, success);
		}

	function Die() {
        require(msg.sender == Owner);
        suicide(Owner);
    }
}	