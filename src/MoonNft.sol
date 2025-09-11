// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoonNft is ERC721, Ownable {
    event CreatedNFT(uint256 indexed tokenId, address indexed minter);

    enum NFTState {
        HAPPY,
        SAD
    }
    mapping(uint256 => NFTState) public s_tokenIdToState;

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

    function mintNft() public returns (uint256) {
        s_tokenCounter++;
        _safeMint(msg.sender, s_tokenCounter);
        emit CreatedNFT(s_tokenCounter, msg.sender);
        return s_tokenCounter;
    }

    function getHappySVG() public view returns (string memory) {
        return happyUri;
    }

    function getSadSVG() public view returns (string memory) {
        return sadUri;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function flipMood(uint256 tokenId) public {
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert();
        }

        if (s_tokenIdToState[tokenId] == NFTState.HAPPY) {
            s_tokenIdToState[tokenId] = NFTState.SAD;
        } else {
            s_tokenIdToState[tokenId] = NFTState.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        string memory imageURI = happyUri;

        if (s_tokenIdToState[tokenId] == NFTState.SAD) {
            imageURI = sadUri;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
