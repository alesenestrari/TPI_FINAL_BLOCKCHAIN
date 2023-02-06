// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

contract Bank {

    mapping(address => uint256) balances;
    address payable public owner;
    
    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function withdraw(uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount , "Insuficient founds.");
        owner.transfer(_amount);
    }

    function withdrawToWallet(uint256 _amount, address _wallet) external onlyOwner {
        require(address(this).balance >= _amount , "Insuficient founds.");
        payable(_wallet).transfer(_amount);
    }

    function withdrawAll() external onlyOwner {
        owner.transfer(address(this).balance);
    }

    receive() external payable {}

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

}