// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract TenderContract {
    struct Experience {
        uint previouslyWonContract;
        string description;
        uint noOfProjectComplected;
    }

    struct SafetyPerson {
        string name;
        uint yearOfExperience;
        string roleDescription;
        string cidNumber;
    }

    struct BuildCost {
        uint labourCost;
        uint plansAndEquipmentCost;
        uint crewCost;
        uint materialsCost;
        uint subContractorCost;
        uint projectOverHeads;
        uint commonPlansAndEquipmentCost;
        uint commonWorkmenCost;
        uint profit;
        uint contingency;
        uint generalOverheads;
        uint allowanceForRisks;
    }

    struct Safety {
        bool useOfPPE;
        bool riskInsurance;
        string description;
        string projectRiskDescription;
        SafetyPerson[] safetPersons;
    }

    struct BuildStandard {
        bool buildInspection;
        uint howFrequent;
    }

    struct staffMangement {
        string teamDescription;
        bool properResourceManagement;
        string resourceManagementDescription;
        bool training;
    }
    
    struct Winner {
        string email;
        Experience experience; 
        BuildCost projectBuildCost;
        Safety safetyDetails;
        BuildStandard buildStandard;

    }

    address public systemGeneratedWinner;
    address public superAdmin;
    uint public tenderStartTime;
    uint public tenderEndTime;

    bool public tenderEnded;

    constructor() {
        superAdmin = msg.sender;
    }


}
