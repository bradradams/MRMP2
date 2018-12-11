pragma solidity ^0.4.24;


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
    mapping(address => uint) stakeholderPercentage;

    uint stHolderCount;

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

        stHolderCount++;
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
        return stHolderCount;
    }

    function() public payable {
        uint amountReceived = msg.value;


        //Unfinished
        //Need to distribute funds to stakeholders
        //Can this be done without floating points?

        emit RoyaltyPayment(rmpId, amountReceived);
    }
}


