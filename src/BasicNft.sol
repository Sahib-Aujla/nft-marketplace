// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256=>string) private s_tokenIdToTokenUri;
    constructor() ERC721("Kutta", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public returns(uint256){
        s_tokenCounter++;
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenIdToTokenUri[s_tokenCounter] = tokenUri;
        return s_tokenCounter;
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory){
        return s_tokenIdToTokenUri[tokenId];
    }
}
