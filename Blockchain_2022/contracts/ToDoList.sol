// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

import "./TaskStatus.sol";
import "./Task.sol";

contract ToDoList {
    uint256 TASK_PRICE = 100 wei;
    mapping(address => Task[]) tasks;
    address public owner;


    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "No permission fot this request");
        _;
    }

    modifier returnable() {
        _;
        if (msg.value > TASK_PRICE){
            payable(msg.sender).transfer(msg.value - TASK_PRICE);
        }
    }


    function updateTaskPrice(uint256 newPrice) public onlyOwner{
        TASK_PRICE = newPrice;
    }

    function withdraw() public onlyOwner{
        payable(owner).transfer(address(this).balance);
    }

    function create(string memory _text) public payable returnable {
        require(msg.value >= TASK_PRICE, "Insufficient founds.");
        tasks[msg.sender].push(Task(_text, TaskStatus.ToDo));
    }

    function update(uint _index, string memory _text) public {
        tasks[msg.sender][_index].text = _text; // Choose this approach 'cause is simpler
    }

    function setDone(uint _index) public {
        _setStatus(_index, TaskStatus.Done);
    }

    function setDoing(uint _index) public {
        _setStatus(_index, TaskStatus.Doing);
    }

    function setToDo(uint _index) public {
        _setStatus(_index, TaskStatus.ToDo);
    }

    function _setStatus(uint _index, TaskStatus _status) internal {
        tasks[msg.sender][_index].status = _status;
    }

    function task(uint _index) public view returns (Task memory) {
        return tasks[msg.sender][_index];
    }
}