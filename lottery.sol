// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract Lottery {
  address public manager;
  address[] public players;

  constructor() public {
    manager = msg.sender;
  }

  /* enter a candidate to the current lottery */
  function enter() public payable {
    require(msg.value > .01 ether);
    players.push(msg.sender);
  }

  /* manager calls to pick a winner and reset game */
  function pickWinner() public restricted returns(address) {
    uint index = random() % players.length;
    payable(players[index]).transfer(address(this).balance);
    address winner = players[index];
    //  reset players
    players = new address[](0);
    return winner;
  }

  /* get current balance of contract */
  function getCurrentBalance() public view returns(uint) {
    return address(this).balance / (1 ether);
  }

  /* get number of player */
  function getNumberOfPlayer() public view returns(uint) {
    return players.length;
  }

  /* get players */
  function getPlayers() public view returns(address[] memory) {
    return players;
  }

  /* pseudo random */
  function random() private view returns(uint) {
    return uint(sha256(abi.encodePacked(block.difficulty, block.timestamp, players)));
  }

  modifier restricted() {
    // check if it is called by manager
    require(msg.sender == manager);
    // make sure players is not an empty list
    require(players.length > 0);

    _;
  }
}
