// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TPI_Wallet is Ownable{
    
    event LogWithdrawTo(address fromWallet, address toWallet);

    function withdraw(uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount , "Insuficient founds.");
        payable(owner()).transfer(_amount);
    }

    function withdrawToWallet(uint256 _amount, address _wallet) external onlyOwner {
        require(address(this).balance >= _amount , "Insuficient founds.");
        payable(_wallet).transfer(_amount);
        emit LogWithdrawTo(address(this), _wallet);
    }

    function withdrawAll() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    receive() external payable {}

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

}