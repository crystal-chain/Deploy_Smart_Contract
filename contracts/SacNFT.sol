pragma solidity >=0.6.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
//import "@openzeppelin/contracts/utils/Counters.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
//import '@openzeppelin/contracts/math/SafeMath.sol';


contract SacNFT is ERC721URIStorage {
    uint256 private _tokenIds=0;
    mapping (address => bool) public minters;
    mapping (uint256 => Sac) public sacs;
    // owner of the contract = Crystalchain
    address owner;

    struct Sac{
        string modele;
        string couleur;
        uint256 taille;
        string numeroserie;
    }

    constructor() ERC721("SacNFT", "SNFT")  {
        owner = msg.sender;
    }
    //modifier checks that the caller of the function is the owner
    modifier onlyOwner() {
         require(msg.sender == owner, 'Not Owner');
         _;
    }

    modifier isMinter(){
        require(minters[msg.sender]);
        _;
    }

    function registerMinter(address minter) public {
        require(msg.sender==owner);
        minters[minter]=true;
    }

    function generateSac( address minter, string calldata tokenURI) isMinter public returns(uint256){
        _tokenIds++;
        uint256 newItemId = _tokenIds;
        _mint(minter, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }
    function destroySac(uint256 tokenId) public {
        require(msg.sender==ownerOf(tokenId)); 
       _burn(tokenId);
    }           
}