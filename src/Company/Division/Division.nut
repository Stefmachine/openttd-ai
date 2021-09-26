using("MBAi.Utils.Array");
using("MBAi.Common.AbstractClass");
using("MBAi.Logger");

class MBAi.Company.Division.Division extends MBAi.Common.AbstractClass
{
    static DIVISION_ANY = "*";

    company = null
    TASKS_OPERATIONS = {}

    constructor(_company)
    {
        this.company = _company;
        this.ensureSlotImplementation("getName", "MBAi.Company.Division.Division");
        this.ensureSlotImplementation("createTasksFromEvent", "MBAi.Company.Division.Division");
        this.ensureSlotImplementation("createTasks", "MBAi.Company.Division.Division");
        this.ensureSlotImplementation("getTasksOperations", "MBAi.Company.Division.Division");
        this.TASKS_OPERATIONS = this.getTasksOperations();
    }

    function getPersonnel()
    {
        return MBAi.Utils.Array.filter(this.company.personnel.toArray(), function(_person, _index, _personnel){
            return _person.division == this.getName();
        });
    }

    function getJokerPersonnel()
    {
        return MBAi.Utils.Array.filter(this.company.personnel.toArray(), function(_person, _index, _personnel){
            return _person.division == MBAi.Company.Division.Division.DIVISION_ANY;
        });
    }

    function getTasks()
    {
        return MBAi.Utils.Array.filter(this.company.tasks.toArray(), function(_task, _index, _tasks){
            return _task.division == this.getName();
        });
    }

    function getTasksPriority()
    {
        return ::MBAi.Utils.Array.map(this.TASKS_OPERATIONS, function(_taskOp, _index, _taskOps){
            return _taskOp.id;
        });
    }

    function getPersonnelTask(_personnel)
    {
        return ::MBAi.Utils.Array.find(this.getTasks(), function(_task, _index, _tasks):(_personnel){
            return _task.assignedPersonnel != null && _task.assignedPersonnel == _personnel.id;
        });
    }

    function getPrioritisedUnassignedTasks()
    {
        local tasks = ::MBAi.Utils.Array.filter(this.getTasks(), function(_task, _index, _tasks){
            return _task.assignedPersonnel == null;
        });

        local priorities = this.getTasksPriority();
        tasks.sort(function(_taskA, _taskB):(priorities){
            local priorityA = ::MBAi.Utils.Array.indexOf(priorities, _taskA.type);
            local priorityB = ::MBAi.Utils.Array.indexOf(priorities, _taskB.type);
            priorityA = (priorityA > -1 ? priorityA : priorities.len());
            priorityB = (priorityB > -1 ? priorityB : priorities.len());

            return priorityA == priorityB ? 0 : (priorityA > priorityB ? 1 : -1);
        });

        return tasks;
    }

    function getFreePersonnel()
    {
        return ::MBAi.Utils.Array.filter(this.getPersonnel(), function(_person, _index, _personnel){
            return this.getPersonnelTask(_person) == null;
        });
    }

    function addPersonnel(_personnel)
    {
        _personnel.division = this.getName();
    }

    function addTask(_task)
    {
        _task.division = this.getName();
        this.company.tasks.add(_task);
        ::MBAi.Logger.debug("Added '{type}' task to {division} with info: {info}", {type = _task.type, division = _task.division, info = _task.info});
        return _task;
    }

    function assignTasks()
    {
        local freePersonnel = this.getFreePersonnel();

        foreach (personnel in freePersonnel) {
            this.assignPersonnelToAnyTask(personnel);
        }
    }

    function assignPersonnelToAnyTask(_personnel)
    {
        local tasks = this.getPrioritisedUnassignedTasks();
        if(tasks.len() > 0){
            local task = tasks[0];
            task.assignTo(_personnel);
            ::MBAi.Logger.debug("Assigned task '{type}(#{tid})' of {division} division to {name}(#{pid}).", {
                type = task.type,
                tid = task.id,
                division = task.division,
                name = _personnel.name,
                pid = _personnel.id
            });
            return true;
        }

        return false;
    }

    function carryOutTasks()
    {
        foreach (task in this.getTasks()) {
            if(task.assignedPersonnel != null){
                this.performTask(task);
            }
        }
    }

    function performTask(_task)
    {
        local taskOp = ::MBAi.Utils.Array.find(this.TASKS_OPERATIONS, function(_taskOp, _index, _taskOps):(_task){
            return _taskOp.id == _task.type;
        });

        local taskDone = true;
        if(taskOp != null){
            taskDone = taskOp.perform(_task);
        }
        else{
            ::MBAi.Logger.debug("No actions found for task '{type}' in {division}.", {type = _task.type, division = this.getName()});
        }

        if(taskDone){
            if(_task.assignedPersonnel != null){
                local personnel = this.company.personnel.findById(_task.assignedPersonnel);
                if(personnel != null){
                    personnel.tasksDone++;
                }
            }

            this.company.tasks.remove(_task);
        }
    }
}