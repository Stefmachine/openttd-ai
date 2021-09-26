using("MBAi.Logger");
using("MBAi.Common.AbstractClass");
using("MBAi.Company.Task.Task");

class MBAi.Company.Division.Task.TaskExecution extends MBAi.Common.AbstractClass
{
    constructor()
    {
        this.ensureSlotImplementation("id", "MBAi.Company.Division.Task.TaskExecution");
        this.ensureSlotImplementation("execute", "MBAi.Company.Division.Task.TaskExecution");
    }

    /**
     * Returns true if the task was fully completed
     */
    function perform(_task)
    {
        try {
            return this.execute(_task);
        } catch (ex){
            if(!(typeof ex == "instance" && ex instanceof ::MBAi.Company.Division.Task.TaskExecution.Failure)){
                throw ex;
            }
            ex.report();
            return this.onFail(_task);
        }
    }

    function fail(_message, _context)
    {
        throw ::MBAi.Company.Division.Task.TaskExecution.Failure(_message, _context);
    }

    function onFail(_task)
    {
        // Handler if the task fails. No-op by default.
        return true;
    }

    // STATIC
    function createTask(_id, _info)
    {
        local task = ::MBAi.Company.Task.Task();
        task.type = _id; // No way to get current invoking static class
        task.info = _info;
        return task;
    }
}

class MBAi.Company.Division.Task.TaskExecution.Failure
{
    message = null;
    context = null;

    constructor(_message, _context = {})
    {
        this.message = _message;
        this.context = _context;
    }

    function report()
    {
        ::MBAi.Logger.debug(this.message, this.context);
    }
}