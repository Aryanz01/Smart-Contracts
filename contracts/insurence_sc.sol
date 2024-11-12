// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsuranceContract {
    address public insurer;

    struct Policy {
        address policyholder;
        uint256 premium;
        uint256 coverage;
        uint256 duration; // Duration in seconds
        uint256 startTime; // Timestamp when policy is issued
        bool active;
    }

    struct Claim {
        uint256 amount;
        string reason;
        bool approved;
        bool paid;
    }

    mapping(address => Policy) public policies;
    mapping(address => Claim[]) public claims;

    event PolicyIssued(address indexed policyholder, uint256 premium, uint256 coverage, uint256 duration);
    event PremiumPaid(address indexed policyholder, uint256 amount);
    event ClaimSubmitted(address indexed policyholder, uint256 amount, string reason);
    event ClaimApproved(address indexed policyholder);
    event ClaimPaid(address indexed policyholder, uint256 amount);

    modifier onlyInsurer() {
        require(msg.sender == insurer, "Not authorized");
        _;
    }

    constructor() {
        insurer = msg.sender;
    }

    function issuePolicy(address _policyholder, uint256 _premium, uint256 _coverage, uint256 _duration) external onlyInsurer {
        policies[_policyholder] = Policy(_policyholder, _premium, _coverage, _duration, block.timestamp, true);
        emit PolicyIssued(_policyholder, _premium, _coverage, _duration);
    }

    function payPremium() external payable {
        Policy storage policy = policies[msg.sender];
        require(policy.active, "Policy inactive");
        require(block.timestamp < policy.startTime + policy.duration, "Policy expired");
        require(msg.value == policy.premium, "Incorrect premium");

        emit PremiumPaid(msg.sender, msg.value);
    }

    function isPolicyActive(address _policyholder) public view returns (bool) {
        Policy memory policy = policies[_policyholder];
        return (policy.active && block.timestamp < (policy.startTime + policy.duration));
    }

    function submitClaim(uint256 _amount, string calldata _reason) external {
        Policy memory policy = policies[msg.sender];
        require(policy.active, "Policy inactive");
        require(block.timestamp < (policy.startTime + policy.duration), "Policy expired");

        claims[msg.sender].push(Claim(_amount, _reason, false, false));
        emit ClaimSubmitted(msg.sender, _amount, _reason);
    }

    function approveClaim(address _policyholder, uint256 _claimIndex) external onlyInsurer {
        require(_claimIndex < claims[_policyholder].length, "Invalid claim index");
        claims[_policyholder][_claimIndex].approved = true;
        emit ClaimApproved(_policyholder);
    }

    function payClaim(address payable _policyholder, uint256 _claimIndex) external onlyInsurer {
        Claim storage claim = claims[_policyholder][_claimIndex];
        require(claim.approved, "Claim not approved");
        require(!claim.paid, "Claim already paid");

        claim.paid = true;
        _policyholder.transfer(claim.amount);

        emit ClaimPaid(_policyholder, claim.amount);
    }
}
