// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract Certificates is ERC1155 {
    using Strings for uint;

    mapping (uint256 => string) private _nameCertificate;
    mapping (address => bool) private _issuers;
    uint256 private _totalSupply;

    constructor() ERC1155("ipfs.io/ipfs/QmXPd1f3E8Q2BJwTj7kuss2KLwLZUXvUmbaXkBCmHjuSwp?filename=dotlabs.webp"){
        _issuers[msg.sender] = true;
    }

    modifier onlyIssuers(){
        require(_issuers[msg.sender], "Only Issuers can emite certificates");
        _;
    }

    function addIssuer(address _user) external onlyIssuers(){
        _issuers[_user] = true;
    }

    /**
     * 
     * Function to emit certificate to 1 user
     * 
     * @param _user the address of the user that will receive the token 
     * @param _name name of the certificate to emit
     *
     * NOTE: by default it will mint 1 certificate per user
     */
    function emitNewCertificate(address _user, string calldata _name) external onlyIssuers(){
        uint256 _id = _totalSupply;
        _mint(_user, _id, 1,"");
        _nameCertificate[_id] = _name;
        _totalSupply++;
    }

    function isIssuer(address _user) external view returns(bool){
        return _issuers[_user];
    }

    function certificateName(uint256 _tokenId) external view returns(string memory){
        return _nameCertificate[_tokenId];
    }

    function totalCertificatesEmitted() external view returns(uint256){
        return _totalSupply;
    }
}