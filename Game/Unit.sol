pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IntGameObject.sol";

contract Unit is IntGameObject {

    int16 public damage;
    int16 public def;
    int16 public hp;

    address public enemy;

    function death() private {
        tvm.accept();
        enemy.transfer(1, false, 160);
    }
    
    function attack(IntGameObject enemyPlayerAdress) public {
        tvm.accept();
        enemyPlayerAdress.getAttack(damage);
    }

    function getAttack(int16 enemy_damage) external override {
        tvm.accept();
        enemy = msg.sender;
        enemy_damage -= def;
        hp -= enemy_damage;
        if (hp < 1) {
            death();
        }
    }

    function getInfo() public view returns(int16, int16, int16) {
        return (damage, def, hp);
    }
}