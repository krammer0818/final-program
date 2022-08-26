// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Adoption {
    Adopter[500] public adopters;                               //array of adopters' information
    petInfo[500] public pets;                                   //array of pets' information
    mapping (address => bool) uniqueAdopter;                    //map each address to unique adopter to ensure they can only register once
    mapping (address => uint) adopterIdAndAddress;              //map address to their adopter Id
    mapping (address => uint256) originalOwnersPetRegistered;   //map address to people who send their pet away (5 maximum)
    mapping (uint => bool) petExist;                            //map that make sure a petId exist
    uint256 remainingFund;                                      //remaining fund of the contract
    uint petIds = 0;                                            //count the pets
    uint adopterIds = 0;                                        //count the adopters

    constructor() payable {
        remainingFund = msg.value;
    }

    //struct that keeps track of a pet's health statments(used inside pet info)
    struct healthState {
        bool vaccinated;
        uint vaccineConfirmationCode;
        string diseases;
        bool desinsectization;
    }
    //struct that keeps the contact info of the people who send the pet away(used inside pet info)
    struct currentOwner {
        string addressInfo;
        string phoneNumber;
    }
    //struct that keeps each pets' information
    struct petInfo {
        uint petId;                         //unique petId
        uint registerTime;                  //time that the pet is registered
        string breed;
        uint age;
        bool adopted;                       //if this pet has been adopted yet
        int adopterId;                     //if adopted, the adopter's id(-1 if not adopted)
        string vetPhoneNumber;
        currentOwner currentOwnerInfo;
        healthState healthStateInfo;
        bool losted;                        //if this pet has been reported lost
        address finder;                     //if the pet has been lost and found, the finder's address(0 if not losted)
        string finderPhone;
    }

    //struct the keeps the adopters' information
    struct Adopter {
        uint adopterId;         //unique adopterId
        address addr;           //adopter address
        uint petsAdopted;       //number of pets adopter has adopted(5 max)
        int[5] adoptPetId;      //petIds of the pets the adopter has adopted(all -1 if not adopted yet)
        string adopterPhone;
        string adopterAddress;
    }

    //Register a new pet into the system
    function newPetRegister(string memory breed,
        uint age, string memory vetPhoneNumber,
        string memory addressInfo, string memory phoneNumber,
        bool vaccinated, uint vaccineConfirmationCode,
        string memory diseases, bool desinsectization) external payable {

        require(remainingFund >= 5 * 1e17, "contract fund insufficient");
        require(originalOwnersPetRegistered[msg.sender] < 5, "owner has already registered 5 pets");  //each address can at most register 5 pets in order to prevent abandon on purpose
        
        originalOwnersPetRegistered[msg.sender] += 1;
        currentOwner memory ownerInfo = currentOwner(addressInfo, phoneNumber);
        healthState memory healthInfo = healthState(vaccinated, vaccineConfirmationCode, diseases, desinsectization);
        petInfo memory pet = petInfo(petIds, block.timestamp, breed, age, false, -1, vetPhoneNumber, ownerInfo, healthInfo, false, address(0), "");
        pets[petIds] = pet;
        petExist[petIds] = true;
        petIds += 1;
        
        //transfer 0.5 ether if pet is successfully registered
        remainingFund -= 5 * 1e17;
        payable(msg.sender).transfer(5 * 1e17);
    }

    //Register a new adopter
    //Returns the adopterId if successfully registered
    function adopterRegister(string memory adopterPhone, string memory adopterAddress) external {
        require(uniqueAdopter[msg.sender] == false, "adopter has already registered");    //each address can only register once

        Adopter memory adopterInfo = Adopter(adopterIds, msg.sender, 0, [int256(-1),int256(-1),int256(-1),int256(-1),int256(-1)], adopterPhone, adopterAddress);
        adopters[adopterIds] = adopterInfo;
        adopterIds += 1;
        uniqueAdopter[msg.sender] = true;
        adopterIdAndAddress[msg.sender] = uint(adopterIds - 1);
    }

    //adopting a pet
    function adopt(uint petId, uint adopterId) external payable {
        require(msg.value >= 1 ether, "adopting requires 1 ether");                      //adopting requires 1 ether
        require(petExist[petId] == true, "petId does not exist");                   //assert petId actually exist
        require(pets[petId].adopted == false, "pet has already been adopted");              //assert that the pet has not been adopted yet
        require(uniqueAdopter[msg.sender] == true, "message sender has not registered as an adopter");         //assert the adopterId actually exist
        require(adopters[adopterId].addr == msg.sender, "provided adopterId does not match message sender address");    //assert the message sender is the adopter
        require(adopters[adopterId].petsAdopted < 5, "adopter has already adopted 5 pets");       //assert the adopter has adopted less than 5 pets

        if (msg.value > 1 ether) {
            payable(msg.sender).transfer(msg.value - 1e18);
        }
        remainingFund += 1e18;

        pets[petId].adopted = true;
        pets[petId].adopterId = int(adopterId);
        uint numPetsAdopted = adopters[adopterId].petsAdopted;
        adopters[adopterId].adoptPetId[numPetsAdopted] = int(petId);
        adopters[adopterId].petsAdopted += 1;
    }

    //get the pet's information in the system using petId
    function getPetInfo(uint petId) external view returns(petInfo memory) {
        require(petExist[petId] == true, "petId does not exist");
        return pets[petId];
    }

    //report a pet that is lost
    function reportPetLost(uint petId, uint adopterId) external payable {
        require(petExist[petId] == true, "petId does not exist");                   //assert the pet exist
        require(pets[petId].losted == false, "pet lost has already been reported");               //assert the pet has not been reported lost
        require(uniqueAdopter[msg.sender] == true, "message sender has not registered as an adopter");         //assert the adopterId actually exist
        require(adopters[adopterId].addr == msg.sender, "provided adopterId does not match message sender address"); //assert the message sender is the adopter
        require(pets[petId].adopterId == int(adopterId), "this pet is not adopted by this adopter");        //assert the pet is adopted by the adopter
        require(msg.value >= 1 ether, "pet lost report requires 1 ether");                      //reporting lost require 1 ether
        

        if (msg.value > 1 ether) {
            payable(msg.sender).transfer(msg.value - 1e18);
        }
        remainingFund += 1e18;

        pets[petId].losted = true;
    }

    //report a pet found
    //returns the adopter's phone number for the finder to contact
    function reportPetFound(uint petId, string memory phone) external {
        require(petExist[petId] == true, "petId does not exist");       //assert the pet exist
        require(pets[petId].losted == true, "this pet is not lost");    //assert the pet is reported lost
        
        pets[petId].finder = msg.sender;        //store the message sender's address as the pet's finder
        pets[petId].finderPhone = phone;
    }

    //report a pet that's been found has been received
    function reportPetReceived(uint petId, uint adopterId) external payable {
        require(remainingFund >= 1e18, "contract fund insufficient");
        require(petExist[petId] == true, "petId does not exist");                   //assert the pet exist
        require(pets[petId].losted == true, "this pet is not lost");                //assert the pet is reported lost
        require(uniqueAdopter[msg.sender] == true, "message sender has not registered as an adopter");         //assert the adopterId actually exist
        require(adopters[adopterId].addr == msg.sender, "provided adopterId does not match message sender address"); //assert the message sender is the adopter
        require(pets[petId].adopterId == int(adopterId), "this pet is not adopted by this adopter");        //assert the pet is adopted by the adopter

        address finderAdd = pets[petId].finder;
        pets[petId].losted == false;
        pets[petId].finder = address(0);
        pets[petId].finderPhone = "";

        payable(finderAdd).transfer(1e18);                           //if confirmed, transfer 1 ether to the finder
    }

    function getAdopterId() external view returns(uint) {
        require(uniqueAdopter[msg.sender] == true, "message sender has not registered as an adopter");         //assert the adopterId actually exist
        return adopterIdAndAddress[msg.sender];
    }
}
