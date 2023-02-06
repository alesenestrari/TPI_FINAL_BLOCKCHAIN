// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

import "./TaskStatus.sol";

struct Task {
    string text;
    TaskStatus status;
}