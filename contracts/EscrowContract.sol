pragma solidity ^0.5.1;

contract Escrow{

    address dealer;

  //mapping to keep track of deposits sent into the escrow contract
    mapping(address => uint256) public depositsToAmount;

    modifier onlyDealer(){
        require(msg.sender == dealer);
        _;
    }

//deploy contract with deployer's address set to dealer
    constructor() public {
        dealer = msg.sender;
    }

    //receieve deposit from depositor
    // Takes as input the payee'ss address
    function deposit(address payee) public onlyDealer payable {
        uint256 amount = msg.value;
        //assign payment amount to payee
        depositsToAmount[payee] += amount;
    }
//Withdraw deposited funds to payee/ receieving accounts
//Takes a payable payee address as input
    function withdrawDeposit(address payable payee) public onlyDealer {
      //retrieve payment amount from deposits mapping
        uint256 payment = depositsToAmount[payee];
      //reset balance
        depositsToAmount[payee]=0;
      //transfer eth to receieving account
        payee.transfer(payment);
    }
}
