
var HDWalletProvider = require("truffle-hdwallet-provider");

const MNEMONIC = 'peace stable alley intact mystery absent elegant country congress setup letter occur';

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!

    networks: {
        development: {
            host: "127.0.0.1",
            port: 7545,
            network_id: "*",
            gas: 6500000
        },



        ropsten: {
            provider: function() {
                return new HDWalletProvider(MNEMONIC, "https://ropsten.infura.io/v3/269b9f38fe5a45fc9d94739547b20b52")
            },
            network_id: 3,
            gas: 8000000
        }
    }


};