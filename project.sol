// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ResearchFunding {

    struct ResearchProject {
        uint256 id;
        string name;
        address payable researcher;
        uint256 totalFundingGoal;
        uint256 totalRaised;
        uint256 milestoneCount;
        mapping(uint256 => Milestone) milestones;
        bool isFunded;
        bool isCompleted;
    }

    struct Milestone {
        uint256 id;
        string description;
        uint256 goalAmount;
        uint256 fundsRaised;
        bool isAchieved;
        uint256 fundsReleased;
    }

    address public admin;
    uint256 public projectCount;
    mapping(uint256 => ResearchProject) public projects;
    mapping(address => mapping(uint256 => uint256)) public contributions; // address -> projectId -> contribution amount

    event ProjectCreated(uint256 projectId, string name, address researcher, uint256 goal);
    event FundsContributed(uint256 projectId, address funder, uint256 amount);
    event MilestoneAchieved(uint256 projectId, uint256 milestoneId, uint256 fundsReleased);
    event ProjectCompleted(uint256 projectId);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyResearcher(uint256 projectId) {
        require(msg.sender == projects[projectId].researcher, "Only the researcher can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    // Function to create a new research project
    function createProject(string memory name, uint256 goal) public {
        projectCount++;
        ResearchProject storage newProject = projects[projectCount];
        newProject.id = projectCount;
        newProject.name = name;
        newProject.researcher = payable(msg.sender);
        newProject.totalFundingGoal = goal;
        newProject.totalRaised = 0;
        newProject.milestoneCount = 0;
        newProject.isFunded = false;
        newProject.isCompleted = false;

        emit ProjectCreated(projectCount, name, msg.sender, goal);
    }

    // Function for a funder to contribute to a research project
    function contributeToProject(uint256 projectId) public payable {
        ResearchProject storage project = projects[projectId];
        require(!project.isCompleted, "Project is completed, no more contributions allowed");
        require(msg.value > 0, "Contribution must be greater than 0");

        project.totalRaised += msg.value;
        contributions[msg.sender][projectId] += msg.value;

        // Check if project has been fully funded
        if (project.totalRaised >= project.totalFundingGoal) {
            project.isFunded = true;
        }

        emit FundsContributed(projectId, msg.sender, msg.value);
    }

    // Function for the researcher to define milestones
    function defineMilestone(uint256 projectId, string memory description, uint256 goalAmount) public onlyResearcher(projectId) {
        ResearchProject storage project = projects[projectId];
        require(!project.isCompleted, "Project is already completed");

        uint256 milestoneId = project.milestoneCount++;
        Milestone storage newMilestone = project.milestones[milestoneId];
        newMilestone.id = milestoneId;
        newMilestone.description = description;
        newMilestone.goalAmount = goalAmount;
        newMilestone.fundsRaised = 0;
        newMilestone.isAchieved = false;
        newMilestone.fundsReleased = 0;
    }

    // Function for contributors to release funds after milestone achievement
    function releaseMilestoneFunds(uint256 projectId, uint256 milestoneId) public onlyResearcher(projectId) {
        ResearchProject storage project = projects[projectId];
        Milestone storage milestone = project.milestones[milestoneId];

        require(!milestone.isAchieved, "Milestone already achieved");
        require(project.totalRaised >= milestone.goalAmount, "Not enough funds raised for milestone");

        milestone.isAchieved = true;
        milestone.fundsReleased = milestone.goalAmount;
        project.researcher.transfer(milestone.goalAmount);

        emit MilestoneAchieved(projectId, milestoneId, milestone.fundsReleased);
    }

    // Function to mark the project as completed
    function markProjectAsCompleted(uint256 projectId) public onlyResearcher(projectId) {
        ResearchProject storage project = projects[projectId];
        require(project.isFunded, "Project is not funded yet");
        project.isCompleted = true;

        emit ProjectCompleted(projectId);
    }

    // Function to get project details
    function getProjectDetails(uint256 projectId) public view returns (
        string memory name,
        address researcher,
        uint256 totalFundingGoal,
        uint256 totalRaised,
        bool isFunded,
        bool isCompleted
    ) {
        ResearchProject storage project = projects[projectId];
        return (
            project.name,
            project.researcher,
            project.totalFundingGoal,
            project.totalRaised,
            project.isFunded,
            project.isCompleted
        );
    }

    // Function to get milestone details for a project
    function getMilestoneDetails(uint256 projectId, uint256 milestoneId) public view returns (
        string memory description,
        uint256 goalAmount,
        uint256 fundsRaised,
        bool isAchieved,
        uint256 fundsReleased
    ) {
        ResearchProject storage project = projects[projectId];
        Milestone storage milestone = project.milestones[milestoneId];
        return (
            milestone.description,
            milestone.goalAmount,
            milestone.fundsRaised,
            milestone.isAchieved,
            milestone.fundsReleased
        );
    }
}
