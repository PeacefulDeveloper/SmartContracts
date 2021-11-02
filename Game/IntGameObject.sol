pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface IntGameObject {
    function getAttack(int16 damage) external;
}
