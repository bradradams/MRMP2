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

    struct stakeholder {
        bytes32 name; //Stakeholder's name
        bytes32 title; //Stakeholder's title i.e. songwriter, composer, musician, organization, other
        uint percentage; //Integer 1 to 100 indicating percentage of royalties
        address addr; //Stakeholder's Ethereum address
    }

    mapping (uint256 => stakeholder) private stHolder; //List of stakeholders, (0 to stHolderCount - 1)

    uint256 stHolderCount;

    event RoyaltyPayment(uint256 tokenId, uint amount);




    constructor() public {
    }

    function initRMPcont(uint256 _rmpId, address _rmpManager, address _trustee) public {
        require(msg.sender == rmpManager);
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
        require(msg.sender == rmpManager || msg.sender == trustee);
        stHolder[stHolderCount] = stakeholder(_name, _title, _percentage, _addr);
        stHolderCount++;
    }

    function getStakeholder(uint index) public view returns(
        bytes32 _name,
        bytes32 _title,
        uint _percentage,
        address _addr
    )
    {
        stakeholder memory stk = stHolder[index];

        _name = stk.name;
        _title = stk.title;
        _percentage = stk.percentage;
        _addr = stk.addr;
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


