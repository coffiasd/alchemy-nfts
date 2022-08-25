// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainAyden is ERC721URIStorage {
    using Strings for uint256;
    //Counter the number.
    using Counters for Counters.Counter;
    //token ids mint by each address.
    Counters.counter private _tokenIds;
    //storage the level of each tokenId.
    mapping(uint256 => uint256) public tokenIdToLevels;

    //constructor.
    constructor() ERC721("Chain Ayden", "AYDENS") {}
}
