const main = async () => {
    const interestContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const interestContract = await interestContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    });
    await interestContract.deployed();
    console.log("Contract address:", interestContract.address);

    /* 
    * Get Contract Balance
    */

    let contractBalance = await hre.ethers.provider.getBalance(
        interestContract.address
    );

    console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );

    /*
     * Send 2 Interest Submissions
    */
   let interestTxn = await interestContract.showInterest("Message 1...");
   await interestTxn.wait();

   let interestTxn2 = await interestContract.showInterest("Message 2...");
   await interestTxn2.wait();
                                    
    /*
     * Get Contract balance to see what happened!
    */
   contractBalance = await hre.ethers.provider.getBalance(interestContract.address);

   console.log(
       "Contract Balance:",
       hre.ethers.utils.formatEther(contractBalance)
   );

    // let interestCount;
    // interestCount = await interestContract.getTotalInterest()
    // console.log(interestCount.toNumber());
    

    // const [_, randomPerson] = await hre.ethers.getSigners();
    // interestTxn = await interestContract.connect(randomPerson).showInterest("Another message...");
    // await interestTxn.wait();

    let allInterest = await interestContract.getAllInterest();
    console.log(allInterest);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();