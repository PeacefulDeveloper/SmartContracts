pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "Unit.sol";

contract Warrior is Unit {

    constructor() public {
        require(msg.pubkey() == tvm.pubkey(), 103);
        tvm.accept();
        damage = 6;
        def = 5;
        hp = 10;
    }
}