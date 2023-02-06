// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TPI_FINAL is Ownable{

    event LogWithdrawTo(address fromWallet, address toWallet);

    function withdraw(uint256 _amount) external onlyOwner{
        require(address(this).balance >= _amount,"Insuficient founds.");
        payable(owner()).transfer(_amount);
    }

    function withdrawAll() external onlyOwner{
        payable(owner()).transfer(address(this).balance);
    }

    function withdrawToWallet(address _wallet, uint256 _amount) external onlyOwner{
        require(address(this).balance >= _amount,"Insuficient founds.");
        payable(_wallet).transfer(_amount);
        emit LogWithdrawTo(address(this), _wallet);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}

}