pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol';
import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Mintable.sol';

/**
 *
 * RMP721 Non-Fungible Token (Based on ERC721 standard)
 *
 */

contract RMP721 is ERC721Full, ERC721Mintable {

    address rmpManager;
    uint tokenCount;

    uint8 genre; // All=01, Rock=02, Pop=03, Jazz=04, Blues=05, Classical=06, Soul=07, Latin=08, World=09, Metal=10, Alternative=11, Traditional=12, Other=13

    struct metaData {
        address contAddress; //Official contract address for this token
        address trustee; //Ethereum address where the token will be stored
        bytes32 title; //Title of recording
        bytes32 artist; //Title of performer or band
        bytes32 album; //Album, if none use 'single'
        uint rMonth; //Release month
        uint rDay; //Release day
        uint rYear; //Release year
        uint8 genre; //enum Genre : See notes by enum definition above
        bytes32 image; //uri for cover art image stored on IPFS
    }

    mapping (uint256 => metaData) public _mData; //Mapping from Token ID to metadata

    event newToken(uint256 tokenId);

    constructor() ERC721Full("RMP721", "RMP") public {
        rmpManager = msg.sender;
        tokenCount = 0;
    }

    function mintRMP721 (
        uint256 _rmpId,
        address _contAddress,
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
    public
    {
        require(msg.sender == rmpManager);

        _mint(_trustee, _rmpId); //Call to _mint in ERC721

        _mData[_rmpId] = metaData(_contAddress, _trustee, _title, _artist, _album, _rMonth, _rDay, _rYear, _genre, _image);

        tokenCount++;

        emit newToken(_rmpId);
    }

    function getMdata (uint256 _rmpId) public view returns (
        address _contAddress,
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

    {
        metaData memory md = _mData[_rmpId];

        _contAddress = md.contAddress;
        _trustee = md.trustee;
        _title = md.title;
        _artist = md.artist;
        _album = md.album;
        _rMonth = md.rMonth;
        _rDay = md.rDay;
        _rYear = md.rYear;
        _genre = md.genre;
        _image = md.image;
    }
}
