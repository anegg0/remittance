pragma solidity ^0.4.4;

contract Remittance {
		address Owner;
		address sender;
		address exchange;
		uint256 hashEmailedPassword;
		uint256 hashWhisperedPassword;

    event LogTransferToExchange(uint amount,bytes32 doubleHash,uint deadline);

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

	mapping(address => RemittanceToken) Tokens;
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

	function RemittanceAuthenticate(address recipient)
	external
	ownerOnly()
	returns(bool)
	{
		sender = msg.sender;
		require(hashEmailedPassword) == Tokens[recipient].hashPasswordsPair;
		sender.transfer(Tokens[recipient].remittableAmount);
		return true;
		}

	function Die() {
        require(msg.sender == Owner);
        suicide(Owner);
    }
}	