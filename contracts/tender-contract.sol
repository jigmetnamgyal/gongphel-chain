// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract TenderContract {
    // Variables
    struct Experience {
        uint previouslyWonContract;
        string description;
        uint noOfProjectCompleted;
    }

    struct BuildCost {
        string labourCost;
        string plansAndEquipmentCost;
        string materialsCost;
        string allowanceForRisk;
        string generalOverheads;
        string directCost;
        string indirectCost;
        string markupAmount;
    }

    struct StaffMangement {
        string teamDescription;
        uint teamSize;
        bool buildInspection;
        string frequenceyOfMaintenance;
    }
    
    struct Tenderer {
        string email;
        bool systemGeneratedWinner;
        Experience experience; 
        BuildCost projectBuildCost;
        StaffMangement staffManagement;
    }
    
    address public systemGeneratedWinner;
    address public superAdmin;
    uint public tenderStartTime;
    uint public tenderEndTime;

    mapping(address => Tenderer) public tenderers;
    // Events

    event WinnerInfo(address _address, string _email);

    event TenderEnded(uint _endTime);

    event TenderStarted(uint _startTime);

    event TenderSubmitted(Tenderer _tenderer);

    // Modifiers

    modifier validAddress(address _address) { 
        require(_address != address(0), "The address is not valid"); 
        _; 
    }

    modifier onlyAfter(uint _time) { 
        require(block.timestamp > _time, 'should be only after tender is ended');
        _; 
    }

    modifier onlyBefore(uint _time) { 
        require(block.timestamp < _time, 'should be only before tender started'); 
        _; 
    }

    modifier liveTender(uint _startTime, uint _endTime) { 
        require(block.timestamp >= _startTime && block.timestamp <= _endTime, 'Tender submission has ended/not started');
        _; 
    }

    modifier onlyOwner(address _owner) { 
        require(superAdmin == _owner, "Needs to be the owner of the contract");
        _; 
    }

    constructor() {
        superAdmin = msg.sender;
    }

    function setTenderPeriod(uint _endTime) public {
        tenderStartTime = block.timestamp;
        tenderEndTime = tenderStartTime +  _endTime;
    }

    function manuallySetWinner(address _winner) onlyAfter(tenderEndTime) public{
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
        string memory _labourCost,
        string memory _plansAndEquipmentCost,
        string memory _materialsCost,
        string memory _generalOverheads,
        string memory _directCost,
        string memory _indirectCost,
        string memory _markupAmount,
        string memory _allowanceForRisk
    ) public liveTender(tenderStartTime, tenderEndTime){
        tenderers[msg.sender].projectBuildCost.labourCost = _labourCost;
        tenderers[msg.sender].projectBuildCost.plansAndEquipmentCost = _plansAndEquipmentCost;
        tenderers[msg.sender].projectBuildCost.materialsCost = _materialsCost;
        tenderers[msg.sender].projectBuildCost.generalOverheads = _generalOverheads;
        tenderers[msg.sender].projectBuildCost.directCost = _directCost;
        tenderers[msg.sender].projectBuildCost.indirectCost = _indirectCost;
        tenderers[msg.sender].projectBuildCost.markupAmount = _markupAmount;
        tenderers[msg.sender].projectBuildCost.allowanceForRisk = _allowanceForRisk;
    }


    function addTendererStaffManagementDetails(
        string memory _teamDescription,
        uint _teamSize,
        bool _buildInspection,
        string memory _frequenceyOfMaintenance
    ) public liveTender(tenderStartTime, tenderEndTime) {
        tenderers[msg.sender].staffManagement.teamDescription = _teamDescription;
        tenderers[msg.sender].staffManagement.teamSize = _teamSize;
        tenderers[msg.sender].staffManagement.buildInspection = _buildInspection;
        tenderers[msg.sender].staffManagement.frequenceyOfMaintenance = _frequenceyOfMaintenance;
    }

    function get() public view returns (StaffMangement memory) {
        return tenderers[msg.sender].staffManagement;
    }
}