pragma solidity ^0.4.4;

contract Remittance {
		address Owner;
		address sender;
		address exchange;
		uint256 hashEmailedPassword;
		uint256 hashWhisperedPassword;
		bytes transactionData;

    event LogTransferToExchange(address recipient, uint hashPasswordsPair);

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
        Tokens[recipient].recipient = recipient;
		Tokens[recipient].remittableAmount = remittableAmount;
        Tokens[recipient].hashPasswordsPair = keccak256(hashEmailedPassword,hashWhisperedPassword);
		tokenIndex.push(recipient);
		return true;
    }

	function RemittanceTokenAuthenticate(address recipient)
	external
	ownerOnly()
	returns(bool)
	{
		sender = msg.sender;
		require(hashEmailedPassword) == tokens[recipient].hashPasswordsPair;
		// sender.transfer(tokens[recipient].remittableAmount);
		transactionData = eth.getTransaction(txHash).data;
		LogTransferToExchange(t
		tokens[recipient].remittableAmount)
		return true;
		}

	function Die() {
        require(msg.sender == Owner);
        suicide(Owner);
    }
}	