pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "Unit.sol";

contract Archer is Unit {
    
    constructor() public {
        require(msg.pubkey() == tvm.pubkey(), 103);
        tvm.accept();
        damage = 7;
        def = 4;
        hp = 10;
    }
}