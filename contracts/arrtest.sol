
pragma solidity ^0.8.26;



contract array{

    uint8[50] age;
    uint[] phone;

    function setfixarr(uint8 index, uint8 value) public {
        age[index]= value;
    }

    function getfixarr(uint8 index) public view returns (uint8){
        return age[index];
    }

    function setdynamicarr(uint value) public{
        phone.push(value);
    }

    function getdynamicarr(uint index) public view returns (uint){
        return phone[index];
    }

}

 

//SPDX-License-Identifier: MIT

// pragma solidity ^0.6.10;

 

// contract structSample{

 

//   struct learner {

//     string name;

//     uint8 age;

//   }

 

//   mapping (uint8 => learner) public learners;

//   //1 => (Alice, 35)

//   //2 => (Tom, 21)

 

//   function setLearnerDetails (uint8 _key,string memory _name,uint8 _age) public{

//     //learners[1].name="Alice"

//     //learners[1].age=35

//     learners[_key].name = _name;

//     learners[_key].age = _age;

//      }

 

//   function getLearnerDetails (uint8 _key) public view returns(string memory,uint8){

//     return (learners[_key].name,learners[_key].age);

 

// }

// }



// pragma solidity ^0.8.26;

// contract sampstruct{

//     struct student{

//         string name;
//         uint8 age;

//     }

//     mapping (uint8 => student) public students;

//     function one(uint8 key, string memory namee, uint8 agee) public{
//         students[key].name= namee;
//         students[key].age= agee;

//     }

//     function getone(uint8 key ) public view returns(string memory , uint8){
//         return (students[key].name, students[key].age);
//     }




// }



// pragma solidity ^0.8.26;

 

// contract structSample{

//   address public Simplilearn;

//   constructor() public {

//     Simplilearn = msg.sender;

//   }

 

//   modifier onlySimplilearn(){

//     require(msg.sender == Simplilearn);

//     _;

//   }

//   struct learner {

//     string name;

//     uint8 age;

//   }

 

//   mapping (uint8 => learner) public learners;

//   //1 => (Alice, 35)

//   //2 => (Tom, 21)

 

//   function setLearnerDetails (uint8 _key,string memory _name,uint8 _age) public onlySimplilearn{

//     //learners[1].name="Alice"

//     //learners[1].age=35

//     learners[_key].name = _name;

//     learners[_key].age = _age;

//      }

 

//   function getLearnerDetails (uint8 _key) public view returns(string memory,uint8){

//     return (learners[_key].name,learners[_key].age);

 

// }

// }
