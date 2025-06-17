Task No. 1
Create the following smart contracts using Solidity:

1): Voting Contract 

Design a contract that allows users to: 

Propose new candidates 
Cast votes 
Track the total votes per candidate 
Restrict voting to one vote per address 
Declare the winning candidate 
Use appropriate structs, mappings, and access control mechanisms.

2): Depositor and Validator Contract (You can write both contract in single sol file) 

Design a basic simulation of Ethereum 2.0 staking behavior by writing the Depositor and Validator Contracts: 

The `Depositor` can deposit a fixed amount of ETH (32 ETH) into the contract.
Once deposited, the contract marks the sender as a `Validator`. 
Track all validators using a mapping. 
Allow only validators to call a `validate()` function that simulates validation (e.g., emits an event).
