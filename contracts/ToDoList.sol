// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/*
	*@title Contrato que crea y administra una lista de tareas
	*@author erik19borgnia
	*@notice Es un contrato simple con fines educacionales
	*@custom:security No usar este código en producción
*/
contract ToDoList {
    enum Estado {
	    Pendiente,      //0
	    EnProceso,      //1
	    Completada      //2
    }

    // Estructura de datos para representar una tarea
    struct Task {
        string content;
        uint256 createTime;
        Estado state;
    }
    // Array dinámico para almacenar las tareas
    Task[] private s_tasks;



    event TareaCreada(Task task, uint256 createTime);
    event TareaEmpezada(Task task, uint256 startTime);
    event TareaCompletada(Task task, uint256 startTime);
    event TareaEliminada(string content, uint256 deleteTime);


    // Función para agregar una nueva tarea a la lista
    function addTask(string calldata _content) public {
        Task memory newTask = Task(_content, block.timestamp, Estado.Pendiente);
        s_tasks.push(newTask);

        emit TareaCreada(newTask, block.timestamp);
    }

    // Función para marcar como iniciada una tarea
    function startTask(uint _id) public {
        require(_id < s_tasks.length, "START - La tarea con ese id no existe!");
        s_tasks[_id].state = Estado.EnProceso;
        emit TareaEmpezada(s_tasks[_id], block.timestamp);
    }

    // Función para marcar como completada una tarea
    function completeTask(uint _id) public {
        require(_id < s_tasks.length, "COMPLETE - La tarea con ese id no existe!");
        s_tasks[_id].state = Estado.Completada;
        emit TareaCompletada(s_tasks[_id], block.timestamp);
    }

    // Función para ver la cantidad de tareas creadas
    function getTaskCount() public view returns (uint) {
        return s_tasks.length;
    }

    // Función para ver el contenido de una tarea
    function getTaskContent(uint _id) public view returns (Task memory) {
        require(_id < s_tasks.length, "CONTENT - La tarea con ese id no existe!");
        return s_tasks[_id];
    }

    // Función que elimina una tarea a partir de su descripción
    function deleteTask(string calldata _content) public {
        uint i = 0;
        while (i<s_tasks.length && keccak256(abi.encodePacked(_content)) != keccak256(abi.encodePacked(s_tasks[i].content))) {
            i++;
        }
        require(i < s_tasks.length, "DELETE - La tarea con ese contenido no existe!");
        s_tasks[i] = s_tasks[s_tasks.length - 1];
        s_tasks.pop();
        emit TareaEliminada(_content, block.timestamp);
    }
    
}