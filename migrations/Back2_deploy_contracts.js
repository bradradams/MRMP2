
var RMP721 = artifacts.require("RMP721");
var MRMP = artifacts.require("MRMP");

module.exports = function(deployer) {
  deployer.deploy(RMP721).then(function() {
    return deployer.deploy(MRMP, RMP721.address);
  });
};