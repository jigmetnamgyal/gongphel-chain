const main = async () => {
    const tenderContractFactory = await hre.ethers.getContractFactory('TenderContract');
    const tenderContract = await tenderContractFactory.deploy();
    await tenderContract.deployed();

    console.log("The tender contract is deployed to: ", tenderContract.address)
    // let start = await tenderContract.setTenderPeriod('10000');
    // await start.wait();

    // let txn = await tenderContract.addTendererExperience(
    //     'jigme@gmail.com', 12, "this is cool", 2
    // )

    // await txn.wait();

    // let txn1 = await tenderContract.addTendererProjectBuildCostDetails(
    //     '100', '120', '120', '10', '20', '111.12', '12', '15'
    // )

    // await txn1.wait();

    // let txn2 = await tenderContract.addTendererStaffManagementDetails(
    //     'cool team', 20, true, '2.5 per year'
    // )

    // await txn2.wait()
    // get = await tenderContract.get()
    // console.log(get)
}

const runMain = async () => {
    try {
        await main();
        process.exit(0)
    } catch(error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();