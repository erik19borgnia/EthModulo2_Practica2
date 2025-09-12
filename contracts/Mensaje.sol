//SPDX-License-Identifier: MIT 

pragma solidity 0.8.30;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.7.1/contracts/utils/Strings.sol";

/** 
 * @title Contrato Mensaje 
 * @author i3arba - 77 Innovation Labs 
 * @notice Este contrato es parte del primer proyecto del Ethereum Developer Pack 
 * @custom:security Este es un contrato educativo y no debe ser usado en producción 
 */ 
contract Mensaje {
	/*////////////////////////
				Variables de Estado
	////////////////////////*/
	///@notice variable para almacenar mensajes
	uint256 s_ultimo;
	
	/*////////////////////////
					Eventos
	////////////////////////*/
	///@notice evento emitido cuando el mensaje es actualizado
	event Mensaje_MensajeActualizado(string mensaje);
	
	/*////////////////////////
					Funciones
	////////////////////////*/
	function enviarPlatita() public payable returns(uint256 enviado_) {
		enviado_ = msg.value;
		s_ultimo = msg.value;
	}

	function getUltimoEnvio() public view returns(string memory mensaje_){
		mensaje_ = string.concat("Lo ultimo enviado es ",Strings.toString(s_ultimo));
	}
}