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
    uint lastID=0;
    // Array dinámico para almacenar las tareas
    Task[] private s_tasks;



    event TareaCreada(string content, uint256 createTime);
    event TareaEmpezada(uint id, uint256 startTime);
    event TareaCompletada(uint id, uint256 startTime);


    // Función para agregar una nueva tarea a la lista
    function addTask(string memory _content) public {
        Task memory newTask = Task(_content, block.timestamp, Estado.Pendiente);
        s_tasks.push(newTask);

        emit TareaCreada(_content, block.timestamp);

        lastID++;
    }

    // Función para marcar como iniciada una tarea
    function startTask(uint _id) public {
        require(_id < lastID, "START - La tarea con ese id no existe!");
        s_tasks[_id].state = Estado.EnProceso;
        emit TareaEmpezada(_id, block.timestamp);
    }

    // Función para marcar como completada una tarea
    function completeTask(uint _id) public {
        require(_id < lastID, "COMPLETE - La tarea con ese id no existe!");
        s_tasks[_id].state = Estado.Completada;
        emit TareaCompletada(_id, block.timestamp);
    }

    // Función para ver la cantidad de tareas creadas
    function getTaskCount() public view returns (uint) {
        return lastID;
    }

    // Función para ver el contenido de una tarea
    function getTaskContent(uint _id) public view returns (Task memory) {
        require(_id < lastID, "CONTENT - La tarea con ese id no existe!");
        return s_tasks[_id];
    }
    
}