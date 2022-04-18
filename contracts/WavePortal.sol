// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalInterest;

    /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;    

    event NewInterest(address indexed from, uint256 timestamp, string message);

    struct Interest {
        address interested_user;
        string message; 
        uint256 timestamp;
    }

    Interest[] interested;

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Big up to whoever developed these tools.. time to get schwifty :P");
        /*
        * Set the initial seed
        */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function showInterest(string memory _message) public {
        /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        /*
         * Update the current timestamp we have for the user
         */
        lastWavedAt[msg.sender] = block.timestamp;        

        totalInterest += 1;
        console.log("%s is interested - %s!", msg.sender, _message);

        /*
        * This is where we store the interest data into the array
        */
        interested.push(Interest(msg.sender, _message, block.timestamp));

        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            /*
             * The same code we had before to send the prize.
             */
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        /*
         * I added some fanciness here, Google it and try to figure out what it is!
         * Let me know what you learn in #general-chill-chat
         */
        emit NewInterest(msg.sender, block.timestamp, _message);

    }

    /*
     * I added a function getAllInterest which will return the struct array, interest, to us.
     * This will make it easy to retrieve the interest from our website!
     */
    function getAllInterest() public view returns (Interest[] memory) {
        return interested;
    }


    function getTotalInterest() public view returns (uint256) {
        console.log("Total interest: %d", totalInterest);
        return totalInterest;
    }
}