pragma solidity ^0.8.1;


contract Trust {
    struct Kid {
    uint amount;
    uint maturity;
    bool paid;
    }
    mapping (address => Kid) public kids;
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
        kids[kid] = Kid (msg.value, block.timestamp+timeToMaturity, false);
        maturities[kid] = block.timestamp + timeToMaturity;

    } 

    function withdraw() external {
        Kid storage kid = kids[msg.sender];
        require(kid.maturity <= block.timestamp, "too early");
        require(kid.amount > 0, "only kid could withdraw");
        require(kid.paid == false, "paid already !");
        paid[msg.sender] = true;
        // require(block.timestamp >= maturity, "too early");
        // require(msg.sender == kid, "only kid could withdraw");
        // payable(msg.sender).transfer(address(this).balance);
        payable(msg.sender).transfer(amounts[msg.sender]);
    }
}
