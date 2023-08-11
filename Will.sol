pragma solidity ^0.5.7;

contract Will{
    address owner;
    uint fortune;
    uint i;
    bool deceased;

    constructor() payable public{
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;
    }

    // create modifier so that only one person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // create modifier so that we only allocate funds if friend's gramps deceased.
    modifier mustBeDeceased {
        require(deceased== true);
        _;
    }

    //list of family wallet's.
    address payable [] familyWallets;

    //map through inheritance
    mapping(address => uint) inheritance;

    function setInheritance (address payable wallet, uint amount) public{
        // to add wallets to the family wallets  
        familyWallets.push(wallet);
        inheritance[wallet]= amount;
    }

    //pay each family member based on their wallet address.

    function payout() private mustBeDeceased{
        for(i=0; i<familyWallets.length; i++)
        {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    // oracle switch simulation
    function HasDeceased() public onlyOwner{
        deceased =true;
        payout();

    }

}