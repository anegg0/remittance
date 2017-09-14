pragma solidity ^0.4.4;

contract Remittance {
		address Owner;
		address sender;
		address exchange;
		uint256 hashEmailedPassword;
		uint256 hashWhisperedPassword;
		bytes transactionData;

    event LogTokenAuthentication(address recipient, bool success);

	function Remittance() {
		Owner = msg.sender;
	}

	struct RemittanceToken {
		address recipient;
		uint remittableAmount;
		uint256 hashPasswordsPair;
    }

    modifier ownerOnly() {
        require(msg.sender == Owner);
        _;
    }

	mapping(address => RemittanceToken) tokens;
	address[] tokenIndex;
	function RemittanceTokenConstructor(address recipient, uint remittableAmount, uint256 hashEmailedPassword, uint256 hashWhisperedPassword)
	returns(bool success)
	 {
        tokens[recipient].recipient = recipient;
		tokens[recipient].remittableAmount = remittableAmount;
        tokens[recipient].hashPasswordsPair = keccak256(hashEmailedPassword,hashWhisperedPassword);
		tokenIndex.push(recipient);
		return true;
    }

	function TokenAuthenticator(address recipient)
	external
	ownerOnly()
	returns(bool success)
	{
		sender = msg.sender;
		require(recipient == sender);
		require(hashPasswordsPair) == tokens[recipient].hashPasswordsPair;
		sender.transfer(tokens[recipient].remittableAmount);
		// transactionData = eth.getTransaction(txHash).data;
		LogTokenAuthentication(recipient, success);
		return true;
		}

	function Die() {
        require(msg.sender == Owner);
        suicide(Owner);
    }
}	