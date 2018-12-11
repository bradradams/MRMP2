pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/RMPcontract.sol";

contract TestRMPContract {
    event NewContract(address contAdd);

    address _contAddress = new RMPcontract();

    //emit NewContract(_contAddress);
}



/*
contract TestSimpleStorage {

truffle
SimpleStorage simpleStorage = SimpleStorage(DeployedAddresses.SimpleStorage());

simpleStorage.set(89);

uint expected = 89;

Assert.equal(simpleStorage.get(), expected, "It should store the value 89.");
}

}*/
