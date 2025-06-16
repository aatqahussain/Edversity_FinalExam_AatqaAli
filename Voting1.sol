// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Voting {

    // Structure to define a candidate
    struct Candidate {
        string name;
        uint voteCount;
    }

    // Array to store all candidates
    Candidate[] public candidates;

    // Mapping to track whether an address has voted
    mapping(address => bool) public hasVoted;

    // Owner address (the deployer of the contract)
    address public owner;

    // Set owner during deployment
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict function to onlyOwner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Event when a new candidate is added
    event CandidateAdded(string name);

    // Event when someone casts a vote
    event Voted(address voter, uint candidateIndex);

    // Add a new candidate (only owner)
    function addCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate(_name, 0));
        emit CandidateAdded(_name);
    }

    // Cast a vote to a candidate (only once per address)
    function vote(uint candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate index");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount++;

        emit Voted(msg.sender, candidateIndex);
    }

    // Get number of candidates
    function getCandidateCount() public view returns (uint) {
        return candidates.length;
    }

    // Get candidate info by index
    function getCandidate(uint index) public view returns (string memory name, uint voteCount) {
        require(index < candidates.length, "Candidate does not exist");
        Candidate storage candidate = candidates[index];
        return (candidate.name, candidate.voteCount);
    }

    // Get the winner of the vote
    function getWinner() public view returns (string memory winnerName, uint highestVotes) {
        require(candidates.length > 0, "No candidates added yet");

        uint winningVoteCount = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        winnerName = candidates[winnerIndex].name;
        highestVotes = candidates[winnerIndex].voteCount;
    }
}
