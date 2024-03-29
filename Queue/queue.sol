pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
contract queue {
    string[] peoples;

	constructor() public {
		// check that contract's public key is set
		require(tvm.pubkey() != 0, 101);
		// Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	// Modifier that allows to accept some external messages
	modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    function getInLine (string name) public checkOwnerAndAccept {
		peoples.push(name);
	}

    function callOfNext () public checkOwnerAndAccept {
		delete peoples[0];
	}
}