module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "43" // Match any network id
    },
    "net43": {
      host: "localhost",
      port: 8545,
      network_id: 43
    },
    "ropsten": {
      host: "localhost",
      port: 8545,
      network_id: 3
    }
  }
};
