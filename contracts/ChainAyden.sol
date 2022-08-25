// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainAyden is ERC721URIStorage {
    using Strings for uint256;
    //Counter the number.
    using Counters for Counters.Counter;
    //token ids mint by each address.
    Counters.Counter private _tokenIds;
    //storage the level of each tokenId.
    mapping(uint256 => uint256) public tokenIdToLevels;
    mapping(address => uint256) public addressToTokenId;

    //constructor.
    constructor() ERC721("Chain Ayden", "AYDENS") {}

    //generate character.
    //@param tokenId uint256
    function generateCharacter(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            "<style>.base { fill: pink; font-family: serif; font-size: 14px; }</style>",
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Warrior",
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Levels: ",
            getLevel(tokenId),
            "</text>",
            "</svg>"
            "</svg>"
        );

        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    //will return the level(string) of each tokenID.
    //@param tokenId uint246
    function getLevel(uint256 tokenId) public view returns (string memory) {
        uint256 levels = tokenIdToLevels[tokenId];
        return levels.toString();
    }

    //getTokenURI
    //@param tokenId uint256
    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Chain Ayden #',
            tokenId.toString(),
            '",',
            '"description": "Aydens Special NFTs On chain",',
            '"image": "',
            generateCharacter(tokenId),
            '"',
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    //mint every should be able to mint an NFTs.
    function mint() public {
        require(
            addressToTokenId[msg.sender] == 0,
            "Sorry you already mint one!"
        );
        _tokenIds.increment();
        //return the current itemId(uint256).
        uint256 newItemId = _tokenIds.current();
        //_safeMint to msg.ender
        _safeMint(msg.sender, newItemId);
        //set the level of this newItemId to 0.
        tokenIdToLevels[newItemId] = 0;
        //set the item URI.
        _setTokenURI(newItemId, getTokenURI(newItemId));
        addressToTokenId[msg.sender] = newItemId;
    }

    //train to raise our NFTs level.
    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use an existing token");
        require(
            ownerOf(tokenId) == msg.sender,
            "You must own this token to train it"
        );
        uint256 currentLevels = tokenIdToLevels[tokenId];
        tokenIdToLevels[tokenId] = currentLevels + 1;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }

    //mintCounter.
    function getMyTokenId() public view returns (uint256) {
        require(
            addressToTokenId[msg.sender] != 0,
            "Sorry please mint one NFTs first!"
        );
        return addressToTokenId[msg.sender];
    }
}
