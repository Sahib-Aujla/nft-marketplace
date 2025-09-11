// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployMoodNft} from '../script/DeployMoodNft.s.sol';
import {MoonNft} from '../src/MoonNft.sol';

contract TestMoonNft is Test{
    MoonNft moonNft;
    DeployMoodNft deployer;

    function setUp()public{
        deployer = new DeployMoodNft();
        moonNft = deployer.run();
    }

    function testCheckNameAndSymbol() external view{
        assert(keccak256(bytes(moonNft.name()))==keccak256(bytes("Moon")));
        assert(keccak256(bytes(moonNft.symbol()))==keccak256(bytes("MOON")) );
    }
}