pragma solidity ^0.4.24;

//import "truffle/Assert.sol";
//import "truffle/DeployedAddresses.sol";
import "./RMPcontract.sol";

contract TestRMPContract2 {
    event contCreated(uint8 contAdd);

    uint8 x = 2;

    address _contAddress = new RMPcontract();

    //emit contCreated(_contAddress);
    //emit contCreated(x);
}