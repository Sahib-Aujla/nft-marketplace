// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {BasicNft}  from "../src/BasicNft.sol";
import {Test,console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract TestBasicNft is Test{
    BasicNft basicNft;
    DeployBasicNft deployBasicNft;

    function setUp()public{
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testNameAndSymbol() external{
        assert(keccak256(abi.encodePacked(basicNft.name()))==keccak256(abi.encodePacked("Kutta")));
        assert(keccak256(abi.encodePacked(basicNft.symbol()))==keccak256(abi.encodePacked("DOG")));
    }

}