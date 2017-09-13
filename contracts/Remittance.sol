pragma solidity ^0.4.4;

contract Remittance {
		address owner;
		address sender;
		address exchange;
		bytes32 EmailedPassword;
		bytes32 WhisperedPassword;
		bytes32 hashedEmailedPassword;
		bytes32 hashedWhisperedPassword;

	function Remittance() {
		owner = msg.sender;
	}

	struct RemittanceToken {
		address recipient;
		uint remittableAmount;
		bytes32 emailedPwd;
		bytes32 whisperedPwd;
    }

    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }

	mapping(address => RemittanceToken) Tokens;
	address[] tokenIndex;
	function RemittanceTokenConstructor(address recipient, uint remittableAmount, bytes32 emailedPassword, bytes32 whisperedPassword)
	returns(bool success)
	 {
        Tokens[recipient].recipient = recipient;
		Tokens[recipient].remittableAmount = remittableAmount;
        Tokens[recipient].emailedPwd = keccak256(emailedPassword);
        Tokens[recipient].whisperedPwd = keccak256(whisperedPassword);
		tokenIndex.push(recipient);
		return true;
    }


	function RemittanceAuthenticate(address recipient, bytes32 emailedPassword, bytes32 whisperedPassword)
	external
	ownerOnly()
	returns(bool)
	{
		sender = msg.sender;
		require(keccak256(emailedPassword) == Tokens[recipient].emailedPwd);
		require(keccak256(whisperedPassword) == Tokens[recipient].whisperedPwd);
		sender.transfer(Tokens[recipient].remittableAmount);
		return true;
	}
		function die()
    {
        require(msg.sender == Owner);
        suicide(Owner);
    }
}	