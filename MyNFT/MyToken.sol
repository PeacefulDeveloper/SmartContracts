
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// This is class that describes you smart contract.
contract MyToken {
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    struct Gun {
        string Name;
        string TypeOfGun;
        uint8 Damage;
        uint8 Range;
        uint8 RateOfFire;
    }

    Gun[] gunsArr;
    mapping (string => uint) gunToOwner;
    mapping (string => uint) priceOfGun;

    modifier uniqueName(string Name) {
        bool flag = true;
        for (uint i=0; i<gunsArr.length; i++) {
            if (gunsArr[i].Name == Name) {
                flag = false;
                break;
            }
        }
        require(flag == true, 101);
        _;
    }

    function creatNewGun(string Name, string TypeOfGun, uint8 Damage, uint8 Range, uint8 RateOfFire) public uniqueName(Name) {
        tvm.accept();
        gunsArr.push(Gun(Name, TypeOfGun, Damage, Range, RateOfFire));
        uint keyAsLastNum = gunsArr.length - 1;
        gunToOwner[Name] = msg.pubkey();
    }

    function sellGun(string Name, uint price) public {
        require(msg.pubkey() == gunToOwner[Name], 100);
		tvm.accept();
        priceOfGun[Name] = price;
    }
    
}
