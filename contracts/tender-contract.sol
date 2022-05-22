// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract TenderContract {
    // Variables
    struct Experience {
        uint previouslyWonContract;
        string description;
        uint noOfProjectCompleted;
    }

    struct SafetyPerson {
        string name;
        uint yearOfExperience;
        string roleDescription;
    }

    struct BuildCost {
        uint labourCost;
        uint plansAndEquipmentCost;
        uint materialsCost;
        uint profit;
        uint generalOverheads;
        uint directCost;
        uint indirectCost;
        uint markupAmount;
    }

    struct Safety {
        bool useOfPPE;
        bool riskInsurance;
        string description;
        string projectRiskDescription;
        SafetyPerson[] safetyPersons;
    }

    struct BuildStandard {
        bool buildInspection;
        uint howFrequent;
    }

    struct StaffMangement {
        string teamDescription;
        bool properResourceManagement;
        string resourceManagementDescription;
        bool training;
    }
    
    struct Tenderer {
        string email;
        bool systemGeneratedWinner;
        Experience experience; 
        BuildCost projectBuildCost;
        Safety safetyDetails;
        BuildStandard buildStandard;
        StaffMangement staffManagement;
    }

    address public systemGeneratedWinner;
    address public superAdmin;
    uint public tenderStartTime;
    uint public tenderEndTime;

    bool public tenderEnded;

    mapping(address => Tenderer) public tenderers;

    // Events

    event WinnerInfo(address _address, string _email);

    event TenderEnded(uint _endTime);

    event TenderStarted(uint _startTime);

    event TenderSubmitted(Tenderer _tenderer);

    // Modifiers

    modifier validAddress(address _address) { require(_address != address(0)); _; }

    modifier onlyAfter(uint _time) { require(block.timestamp > _time); _; }

    modifier onlyBefore(uint _time) { require(block.timestamp < _time); _; }

    modifier liveTender(uint _startTime, uint _endTime) { 
        require(block.timestamp >= _startTime && block.timestamp <= _endTime);
        _; 
    }

    modifier onlyOwner(address _owner) { require(superAdmin == _owner); _; }

    constructor() {
        superAdmin = msg.sender;
    }

    function setTenderPeriod(uint _startTime, uint _endTime) public {
        tenderStartTime = _startTime;
        tenderEndTime = _endTime;
    }

    function manuallySetWinner(address _winner) public{
        systemGeneratedWinner = _winner;
    }

    function getWinnerDetails() onlyAfter(tenderEndTime) public view returns (Tenderer memory) {
        return tenderers[systemGeneratedWinner];
    }

    function addTendererExperience(
        string memory _email,
        uint _previouslyWonContract,
        string memory _description,
        uint _noOfProjectCompleted
    ) public liveTender(tenderStartTime, tenderEndTime){
        tenderers[msg.sender].email = _email;
        tenderers[msg.sender].experience.previouslyWonContract = _previouslyWonContract;
        tenderers[msg.sender].experience.description = _description;
        tenderers[msg.sender].experience.noOfProjectCompleted = _noOfProjectCompleted;
    }

    function addTendererProjectBuildCostDetails(
        uint _labourCost,
        uint _plansAndEquipmentCost,
        uint _materialsCost,
        uint _profit,
        uint _generalOverheads,
        uint _directCost,
        uint _indirectCost,
        uint _markupAmount
    ) public liveTender(tenderStartTime, tenderEndTime) {
        tenderers[msg.sender].projectBuildCost.labourCost = _labourCost;
        tenderers[msg.sender].projectBuildCost.plansAndEquipmentCost = _plansAndEquipmentCost;
        tenderers[msg.sender].projectBuildCost.materialsCost = _materialsCost;
        tenderers[msg.sender].projectBuildCost.profit = _profit;
        tenderers[msg.sender].projectBuildCost.generalOverheads = _generalOverheads;
        tenderers[msg.sender].projectBuildCost.directCost = _directCost;
        tenderers[msg.sender].projectBuildCost.indirectCost = _indirectCost;
        tenderers[msg.sender].projectBuildCost.markupAmount = _markupAmount;
    }

     function addTenderersafetyDetails(
        bool _useOfPPE,
        bool _riskInsurance,
        string memory _safetyDescription,
        string memory _projectRiskDescription,
        SafetyPerson[] memory _safetyPersons
    ) public liveTender(tenderStartTime, tenderEndTime) {
        //add safetyDetails
        tenderers[msg.sender].safetyDetails.useOfPPE = _useOfPPE;
        tenderers[msg.sender].safetyDetails.riskInsurance = _riskInsurance;
        tenderers[msg.sender].safetyDetails.description = _safetyDescription;
        tenderers[msg.sender].safetyDetails.projectRiskDescription = _projectRiskDescription;

        for(uint i = 0; i < _safetyPersons.length; i++) {
            tenderers[msg.sender].safetyDetails.safetyPersons[i] = _safetyPersons[i];
        }
    }

    function addTendererBuildStandardDetails(
        bool _buildInspection,
        uint _howFrequent
    ) public liveTender(tenderStartTime, tenderEndTime) {
        tenderers[msg.sender].buildStandard.buildInspection = _buildInspection;
        tenderers[msg.sender].buildStandard.howFrequent = _howFrequent;
    }

    function addTendererStaffManagementDetails(
        string memory _teamDescription,
        bool _properResourceManagement,
        string memory _resourceManagementDescription,
        bool _training
    ) public liveTender(tenderStartTime, tenderEndTime) {
        tenderers[msg.sender].staffManagement.teamDescription = _teamDescription;
        tenderers[msg.sender].staffManagement.properResourceManagement = _properResourceManagement;
        tenderers[msg.sender].staffManagement.resourceManagementDescription = _resourceManagementDescription;
        tenderers[msg.sender].staffManagement.training = _training;
    }

}
