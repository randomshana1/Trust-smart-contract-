pragma solidity ^0.8.1;

contract Trust {
    address public kid;
    uint256 public maturity;

    constructor(address _kid, uint256 timeToMaturity) payable {
        maturity = block.timestamp + timeToMaturity;
        kid = _kid;
    }

    function withdraw() external {
        require(block.timestamp >= maturity, "too early");
        require(msg.sender == kid, "only kid could withdraw");
        payable(msg.sender).transfer(address(this).balance);
    }
}
