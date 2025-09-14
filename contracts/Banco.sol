//SPDX-License-Identifier: MIT 

pragma solidity 0.8.30;

contract Banco{
    address public owner;

    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "No podes extraer de una cuenta que no es tuya!");
        _;
    }

    event Deposited(address from, uint amount);
    event Extracted(uint amount);

    function deposit() public payable {
        
        emit Deposited(msg.sender, msg.value);
    }

    function extract(uint amount) public onlyOwner {
        require(amount > 0, "No podes extraer 0");
        if (amount > address(this).balance)
        {
            amount = address(this).balance;
        }
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Extraccion fallida.");
        //payable(msg.sender).transfer(amount); //Por qué no usar esto? Básicamente porque transfer y send presuponen que 2300 gas es suficiente, y podría no serlo
        //Por otro lado, CUIDADO con ataques de reentrada!
            
        emit Extracted(amount);        
    }

    function getSmartContractBalance() external view returns(uint balance_) {
        balance_ = address(this).balance;
    }


}