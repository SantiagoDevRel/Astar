require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const { PRIVATE_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "shibuya",
  solidity: "0.8.18",
  networks: {
    shibuya: {
      url: "https://evm.shibuya.astar.network",
      chainId: 81,
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: "",
  },
};
