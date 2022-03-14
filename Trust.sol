pragma solidity ^0.8.1;


contract Trust {
    struct kid {
    uint amount;
    uint maturity;
    bool paid;
    }
    mapping (address => kid) public kids;
    mapping(address => uint) public amounts;
    mapping(address => uint) public maturities;
    mapping (address=>bool) public paid;
    address public admin;
    // address public kid;
    // uint256 public maturity;

    // constructor(address _kid, uint256 timeToMaturity) payable {
    //     maturity = block.timestamp + timeToMaturity;
    //     kid = _kid;
    // }
    constructor() {
        admin = msg.sender;

    }

    function addKid(address kid,uint timeToMaturity) external payable {
        require(msg.sender == admin, 'only admin');
        require(amounts[msg.sender] == 0, "kid already exist");
        amounts[kid] =  msg.value;
        maturities[kid] = block.timestamp + timeToMaturity;

    } 

    function withdraw(address kid) external {
        require(maturities[msg.sender] <= block.timestamp, "too early");
        require(amounts[msg.sender] > 0, "only kid could withdraw");
        require(paid[msg.sender]== false, "paid already !");
        paid[msg.sender] = true;
        // require(block.timestamp >= maturity, "too early");
        // require(msg.sender == kid, "only kid could withdraw");
        // payable(msg.sender).transfer(address(this).balance);
        payable(msg.sender).transfer(amounts[msg.sender]);
    }
}
