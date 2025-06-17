// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

//Task:1 Part 2 Depositor Contract

contract depositor {

// address of deployer=contract owner
address public owner;

// Minimum Deposit Amount (32 Eth)
uint256 public minimumDeposit = 32 ether;  

  
// Mapping to check address deposits
mapping(address=> uint256) public deposits;

event Deposited(address indexed depositor,uint256 amount);

event Withdrawn(address indexed withdrawer ,uint256 amount);
//constructor to initialize the contract with owner as deployer address. 

constructor() {
        owner = msg.sender;
    }

    function deposit () external payable {


        if(minimumDeposit >0)
            require (msg.value >= minimumDeposit, "Minimum Deposit Amount is not Reached");
    
        deposits[msg.sender] += msg.value;  
        
        emit Deposited(msg.sender, msg.value);

    }
    


function getContractBalance() public view returns (uint256) {
    return address(this).balance;

    }

function getUserBalance () external view returns (uint256) {
return deposits[msg.sender];

}

//function to withdraw how much withdraw by address or user

function withdraw () external payable {
uint256 amount = deposits[msg.sender];

require(amount > 0, "No Balance To Withdraw");  

//Reset the users deposit balance
deposits[msg.sender] = 0;

//transfer user's amount from current contract to wallet address 
payable(msg.sender).transfer(amount);

// Emit a withdrawl event
emit Withdrawn (msg.sender , msg.value);
        
    
}

}










//Task:1  Part2 (Validator Contract)
contract Validator {

    // Fixed staking requirement
    uint public constant STAKE_AMOUNT = 32 ether;

    // Track who is a validator
    mapping(address => bool) public isValidator;

    // Track how much each address has deposited
    mapping(address => uint) public deposits;

    // Event: Someone became a validator
    event BecameValidator(address indexed validator);

    // Event: Validator performed validation
    event Validated(address indexed validator, uint timestamp);

    // Event: Validator withdrew funds
    event Withdrawn(address indexed validator, uint amount);

    // Deposit 32 ETH and become a validator
    function deposit() public payable {
        require(msg.value == STAKE_AMOUNT, "You must deposit exactly 32 ETH");
        require(!isValidator[msg.sender], "Already a validator");

        isValidator[msg.sender] = true;
        deposits[msg.sender] = STAKE_AMOUNT;

        emit BecameValidator(msg.sender);
    }

    // Modifier: only for validators
    modifier onlyValidator() {
        require(isValidator[msg.sender], "Only validators allowed");
        _;
    }

    // Simulate a validator performing a validation
    function validate() public onlyValidator {
        emit Validated(msg.sender, block.timestamp);
    }

    // Allow validators to withdraw their stake
    function withdraw() public onlyValidator {
        uint amount = deposits[msg.sender];
        require(amount > 0, "No balance to withdraw");

        // Reset validator status and balance
        isValidator[msg.sender] = false;
        deposits[msg.sender] = 0;

        payable(msg.sender).transfer(amount);

        emit Withdrawn(msg.sender, amount);
    }

    // Check validator status
    function checkValidatorStatus(address _addr) public view returns (bool) {
        return isValidator[_addr];
    }

    // Check contract balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}