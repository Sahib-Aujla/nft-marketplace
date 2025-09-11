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
}