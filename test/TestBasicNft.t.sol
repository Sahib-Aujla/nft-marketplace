// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {BasicNft} from "../src/BasicNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract TestBasicNft is Test {
    BasicNft basicNft;
    DeployBasicNft deployBasicNft;
    address USER = makeAddr("user");

    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testNameAndSymbol() external view {
        assert(
            keccak256(abi.encodePacked(basicNft.name())) ==
                keccak256(abi.encodePacked("Kutta"))
        );
        assert(
            keccak256(abi.encodePacked(basicNft.symbol())) ==
                keccak256(abi.encodePacked("DOG"))
        );
    }

    function testMintNftAndBalance() external {
        vm.prank(USER);
        string
            memory tokenUri = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
        uint256 tokenId = basicNft.mintNft(tokenUri);
        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(basicNft.tokenURI(tokenId))) ==
                keccak256(abi.encodePacked(tokenUri))
        );
    }

}
