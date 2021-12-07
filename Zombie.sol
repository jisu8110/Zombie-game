pragma solidity ^0.4.19;

contract ZombieFactory {

    // event
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // structure
    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // mapping
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    // zombie 등록
    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }
    // 랜덤 zombie dna 생성
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }
    // 랜덤 zombie 생성
    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
