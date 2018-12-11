pragma solidity ^0.4.24;

import "./SafeMath.sol";

/**
 *
 * Official Royalty Distribution Contract
 * Music Royalty Management Platform
 *
 */



contract RMPcontract {
    uint256 rmpId;
    address rmpManager;
    address trustee;
    address[] stakeholders;
    mapping(address => bytes32) stakeholderName;
    mapping(address => bytes32) stakeholderTitle;
    mapping(address => uint) stakeholderPercentage; // uint from 1 to 100 indicating percentage

    event RoyaltyPayment(uint256 tokenId, uint amount);

    constructor() public {}

    function initRMPcont(uint256 _rmpId, address _rmpManager, address _trustee) public {
        rmpId = _rmpId;
        rmpManager = _rmpManager;
        trustee = _trustee;
    }


    function addStakeholderOfficial(
        bytes32 _name,
        bytes32 _title,
        uint _percentage,
        address _addr
    )
    public
    {

        stakeholders.push(_addr);
        stakeholderName[_addr] = _name;
        stakeholderTitle[_addr] = _title;
        stakeholderPercentage[_addr] = _percentage;

    }

    function getStakeholder(address _address) public view returns(
        bytes32 _name,
        bytes32 _title,
        uint _percentage
    )
    {
        return(stakeholderName[_address], stakeholderTitle[_address], stakeholderPercentage[_address]);
    }

    function getNumStakeholders() public view returns (uint) {
        return stakeholders.length;
    }

    function() external payable {
        uint amountReceived = msg.value;
        uint payment;
        for (uint i = 0; i < stakeholders.length; i++) {
            payment = SafeMath.mul(stakeholderPercentage[stakeholders[i]], amountReceived);
            payment = SafeMath.div(payment, 100);
            stakeholders[i].transfer(payment);
        }
        emit RoyaltyPayment(rmpId, amountReceived);
    }
}


