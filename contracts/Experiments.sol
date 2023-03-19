// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

/**
 * @title Experiments
 */
contract Experiments {
  using SafeMath for uint256;

  uint256 public _totalAllAuctions;

  address[] public _contractAddresses;

  mapping(address => Bid[]) public _bids;
  mapping(address => Auction) public _auctions;

  // packed struct for storage optimization
  struct Bid {
    address bidder; // 160/256 bits
    uint96 amount; // 256/256 bits
  }

  struct Auction {
    uint256 totalBid;
  }

  constructor(address addr1) {
    _contractAddresses = [
      address(0x0000000000000000000000000001),
      address(0x0000000000000000000000000002),
      address(0x0000000000000000000000000003),
      address(0x0000000000000000000000000004),
      address(0x0000000000000000000000000005),
      address(0x0000000000000000000000000006)
    ];

    // 0x1
    _bids[_contractAddresses[0]].push(Bid(addr1, 21));
    _bids[_contractAddresses[0]].push(Bid(addr1, 44));
    _bids[_contractAddresses[0]].push(Bid(addr1, 67));
    _bids[_contractAddresses[0]].push(Bid(addr1, 124));

    _auctions[_contractAddresses[0]] = Auction(256);

    // 0x2
    _bids[_contractAddresses[1]].push(Bid(addr1, 11));
    _bids[_contractAddresses[1]].push(Bid(addr1, 98));
    _bids[_contractAddresses[1]].push(Bid(addr1, 155));

    _auctions[_contractAddresses[1]] = Auction(264);

    // 0x3
    _bids[_contractAddresses[2]].push(Bid(addr1, 1));
    _bids[_contractAddresses[2]].push(Bid(addr1, 2));
    _bids[_contractAddresses[2]].push(Bid(addr1, 3));
    _bids[_contractAddresses[2]].push(Bid(addr1, 4));
    _bids[_contractAddresses[2]].push(Bid(addr1, 5));

    _auctions[_contractAddresses[2]] = Auction(15);
  }

  function expensive_calculateTotalAllAuctions() public returns (uint256) {
    for (uint256 i = 0; i < _contractAddresses.length; i++) {
      _totalAllAuctions += _auctions[_contractAddresses[i]].totalBid;
    }
    return _totalAllAuctions;
  }

  function cheap_calculateTotalAllAuctions() public returns (uint256) {
    uint256 totalAllAuctions = 0;
    address[] memory contractAddresses = _contractAddresses;
    uint256 arrLength = contractAddresses.length;

    for (uint256 i = 0; i < arrLength; ) {
      totalAllAuctions += _auctions[contractAddresses[i]].totalBid;
      unchecked {
        i++;
      }
    }

    _totalAllAuctions = totalAllAuctions;

    return totalAllAuctions;
  }

  function expensive_calculateTotalBidsPerAuction() external {
    for (uint256 i = 0; i < _contractAddresses.length; i++) {
      _auctions[_contractAddresses[i]].totalBid = 0;

      for (uint256 j = 0; j < _bids[_contractAddresses[i]].length; j++) {
        _auctions[_contractAddresses[i]].totalBid += _bids[
          _contractAddresses[i]
        ][j].amount;
      }
    }
  }

  function cheap_calculateTotalBidsPerAuction() external {
    address[] memory contractAddresses = _contractAddresses;
    uint256 arrLength = contractAddresses.length;
    for (uint256 i = 0; i < arrLength; ) {
      uint256 totalBid = 0;
      Bid[] memory bids = _bids[contractAddresses[i]];
      // uint256 bidsLength = bids.length; -- It would be more efficient to use that, if we had 5 or more bids
      for (uint256 j = 0; j < bids.length; ) {
        totalBid += bids[j].amount;
        unchecked {
          j++;
        }
      }

      _auctions[contractAddresses[i]].totalBid = totalBid;
      unchecked {
        i++;
      }
    }
  }

  function storage_transferBid(uint256 tip) public payable {
    Bid storage bid = _bids[address(0x0000000000000000000000000001)][0];

    require(bid.amount > 0, "Bid not present");

    uint256 transferPrice = tip + bid.amount;

    require(transferPrice > bid.amount, "transferPrice is too low");

    bid.bidder = msg.sender;
  }

  function memory_transferBid(uint256 tip) public payable {
    Bid memory bid = _bids[address(0x0000000000000000000000000001)][0];

    require(bid.amount > 0, "Bid not present");

    uint256 transferPrice = tip + bid.amount;

    require(transferPrice > bid.amount, "transferPrice is too low");

    _bids[address(0x0000000000000000000000000001)][0].bidder = msg.sender;
  }

  function storage_transferBid_v2(uint256 tip) public payable {
    Bid storage bid = _bids[address(0x0000000000000000000000000001)][0];

    require(bid.amount > 0, "Bid not present");

    uint256 transferPrice = tip + bid.amount;
    transferPrice += bid.amount;
    transferPrice += bid.amount;
    transferPrice += bid.amount;
    transferPrice += bid.amount;
    transferPrice += bid.amount;

    require(transferPrice > bid.amount, "transferPrice is too low");

    bid.bidder = msg.sender;
  }

  function memory_transferBid_v2(uint256 tip) public payable {
    Bid memory bid = _bids[address(0x0000000000000000000000000001)][0];

    require(bid.amount > 0, "Bid not present");

    uint256 transferPrice = tip + bid.amount;
    transferPrice += bid.amount;
    transferPrice += bid.amount;
    transferPrice += bid.amount;
    transferPrice += bid.amount;
    transferPrice += bid.amount;

    require(transferPrice > bid.amount, "transferPrice is too low");

    _bids[address(0x0000000000000000000000000001)][0].bidder = msg.sender;
  }
}
