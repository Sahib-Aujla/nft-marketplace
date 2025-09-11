// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MoonNft is ERC721, Ownable {
    uint256 private s_tokenCounter;
    string happyUri;
    string sadUri;

    constructor(
        string memory _happyUri,
        string memory _sadUri
    ) ERC721("Moon", "MOON") Ownable(msg.sender) {
        s_tokenCounter = 0;
        happyUri = _happyUri;
        sadUri = _sadUri;
    }
}
