const hre = require("hardhat");

async function main() {
  const SubscriptionAccess = await hre.ethers.getContractFactory("SubscriptionAccess");

  // Set the subscription fee (in wei). For example, 0.01 ETH = 10000000000000000 wei
  const fee = hre.ethers.utils.parseEther("0.01");

  const subscriptionAccess = await SubscriptionAccess.deploy(fee);
  await subscriptionAccess.deployed();

  console.log("SubscriptionAccess deployed to:", subscriptionAccess.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
