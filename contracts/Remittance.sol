pragma solidity ^0.4.4;

contract Remittance {
		address Owner;
		address sender;
		address exchange;
		bytes32 hashEmailedPassword;
		bytes32 hashWhisperedPassword;
		bytes32 lock;
		bytes32 sentLock;
		bytes transactionData;
		uint256 remittableAmount;

        event LogTokenAuthentication(address recipient, bool success);
        event RemittanceTokenCreation(address recipient, uint remittableAmount);

	function Remittance() {
		Owner = msg.sender;
	}

	struct RemittanceToken {
		address recipient;
		uint remittableAmount;
		bytes32 lock;
    }

    modifier ownerOnly() {
        require(msg.sender == Owner);
        _;
    }

	mapping(address => RemittanceToken) tokens;
	address[] tokenIndex;
	function remittanceTokenConstructor(address exchangeAddress, address recipient, uint remittableAmount, bytes32 hashEmailedPassword, bytes32 hashWhisperedPassword)
	returns(bool success)
	 {
		lock = keccak256(hashEmailedPassword, hashWhisperedPassword, exchangeAddress);
        tokens[recipient].recipient = recipient;
		tokens[recipient].remittableAmount = remittableAmount;
        tokens[recipient].lock = lock;
		tokenIndex.push(recipient);
	    RemittanceTokenCreation(recipient, remittableAmount);
		return true;
    }

	function tokenAuthenticator(address recipient, bytes32 sentLock)
	external
	ownerOnly()
	returns(bool success)
	{
		remittableAmount = tokens[recipient].remittableAmount;
		sender = msg.sender;
		require(recipient == sender);
		lock = sentLock;
		if (lock == tokens[recipient].lock) 
		sender.transfer(tokens[recipient].remittableAmount);
		return true;
		LogTokenAuthentication(sender, success);
		}

	function die() {
        require(msg.sender == Owner);
        selfdestruct(Owner);
    }
}		