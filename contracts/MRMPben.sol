pragma solidity ^0.4.24;
//pragma experimental ABIEncoderV2;

import './RMP721.sol';
import './RMPcontract.sol';
import './SimpleStorage.sol';

/**
 *
 * Music Royalty Management Platform
 * Uses RMP721 Non-Fungible Token (Based on ERC721 standard)
 *
 */

contract MRMP {

    address rmpManager;
    //address rmp721Address;
    RMP721 minter;

    //    mapping (uint8 => string[]) internal genreToArtists;
    //
    //    mapping (string => string[]) internal artistToAlbums;
    //
    //    mapping (string => string[]) internal albumToSongs;

    bytes32[] artist;

    mapping(bytes32 => bool) internal artist_exists;

    mapping (uint8 => mapping (uint256 => bytes32)) internal genreToArtists;

    mapping (bytes32 => mapping (uint256 => bytes32)) internal artistToAlbums;

    mapping (bytes32 => mapping (uint256 => bytes32)) internal albumToSongs;


    mapping (bytes32 => uint256) internal songToTokenId;

    mapping (bytes32 => bytes32) internal songToAlbum;

    mapping (bytes32 => bytes32) internal songToImage; // IPFS image link

    mapping (bytes32 => bytes32) internal albumToArtist;



    mapping (uint256 => address) internal rmpIdToContract;

    uint256 numContracts;

    //address _contAddress;



    event NewId(uint256 rmpId);
    event NewContract(address rmpContract);


    constructor(address _rmp721Address) public {
        rmpManager = msg.sender;
        //rmp721Address = _rmp721Address;
        minter = RMP721(_rmp721Address);
    }


    //To add a song:
    //Call generateId to obtain an ID
    //Upload image to IPFS and obtain URI (Needs to be done in javascript????)
    //Call addSong to which adds song and calls generateContract
    //generateContract creates the contract and mints token
    //Call addStakeholder as many times as needed to add all stakeholders to the official contract



    function generateId() public {
        //require(msg.sender == rmpManager);

        //        //function calls _exists from ERC721
        //        uint256 rmpId = 0;
        //        while (rmpId == 0 || _exists(rmpId)) {
        //            rmpId = uint256(now);
        //            //rmpId = uint256(keccak256(bytes((_rYear * _rMonth * _rDay)))); won't compile
        //        }

        uint256 rmpId = uint256(now);
        emit NewId(rmpId);
    }



    function addSong(
        uint256 _rmpId,
        address _trustee,
        bytes32 _title,
        bytes32 _artist,
        bytes32 _album,
        uint _rMonth,
        uint _rDay,
        uint _rYear,
        uint8 _genre,
        bytes32 _image
    )
    public returns (uint)
    {
        require(msg.sender == rmpManager);

        //verify parameters here
        //i.e. require(_genre > 0 && _genre <= 12)

        //check to see if artist exists, if not then add it
        //        bool exists = false;
        //        for (uint256 i = 0; i < artist.length; i++) {
        //           if (keccak256(bytes(artist[i])) == keccak256(bytes(_artist))) exists = true;
        //            // is there a better way? Needs to be tested
        //        }
        //        if (!exists)
        //        artist.push(_artist);

        if(!artist_exists[_artist]) {
            artist.push(_artist);
            artist_exists[_artist] = true;
        }


        //add artist to genreToArtists;

        //add album to artistToAlbums;

        //add song to albumToSongs;


        songToImage[_title] = _image; // IPFS image link

        songToTokenId[_title] = _rmpId;

        songToAlbum[_title] = _album;

        albumToArtist[_album] = _artist;

        //create contract and mint token
        createContract(_rmpId, _trustee, _title, _artist, _album, _rMonth, _rDay, _rYear, _genre, _image);

        return 1;
    }

    function createContract(
        uint256 _rmpId,
        address _trustee,
        bytes32 _title,
        bytes32 _artist,
        bytes32 _album,
        uint _rMonth,
        uint _rDay,
        uint _rYear,
        uint8 _genre,
        bytes32 _image
    )
    public returns (uint)
    {
        require(msg.sender == rmpManager);

        //create contract
        address _contAddress = new RMPcontract();
        //_contAddress = new SimpleStorage();
        emit NewContract(_contAddress);

        RMPcontract RMPcont = RMPcontract(_contAddress);

        RMPcont.initRMPcont(_rmpId, _trustee, rmpManager);

        rmpIdToContract[numContracts] = _contAddress;

        numContracts++;

        //mint token
        minter.mintRMP721(_rmpId, _contAddress, _trustee, _title, _artist, _album, _rMonth, _rDay, _rYear, _genre, _image);

        return 1;
    }

    function addStakeholder(
        uint256 _rmpId,
        bytes32 _name,
        bytes32 _title,
        uint _percentage,
        address _addr
    )
    public
    {
        require(msg.sender == rmpManager); // what about trustee?

        RMPcontract RMPcont = RMPcontract(rmpIdToContract[_rmpId]);

        RMPcont.addStakeholderOfficial(_name, _title, _percentage, _addr);
    }

    function getArtists(uint8 genre, uint256 index) public view returns (bytes32) {
        return genreToArtists[genre][index];
    }

    function getContractAddress(uint256 _rmpId) public view returns (address) {
        return rmpIdToContract[_rmpId];
    }

    //In order to return string[], had to use 'pragma experimental ABIEncoderV2;', warning: don't use on live deployments
    //    function getArtists(uint8 genre) public view returns (string[]) {
    //        return genreToArtists[genre];
    //    }

    //Need more getters like one above, should test above function first

}
