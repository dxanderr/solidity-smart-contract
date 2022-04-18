const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.001"),
    });

    await waveContract.deployed();

    console.log("WavePortal address: ", waveContract.address);
    
    // const [deployer] = await hre.ethers.getSigners();
    // const accountBalance = await deployer.getBalance();

    // console.log("Deploying contracts with account: ", deployer.address);
    // console.log("Account balance: ", accountBalance.toString());

    // const interestContractFactory = await hre.ethers.getContractFactory("WavePortal");
    // const interestContract = await interestContractFactory.deploy();
    // await interestContract.deployed();

    // console.log("WavePortal address: ", interestContract.address);
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