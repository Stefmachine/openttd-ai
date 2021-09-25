using("MBAi.Company.Division.Division");
using("MBAi.World.Subsidy");
using("MBAi.Company.Division.Task.MakeSubsidyProject");

class MBAi.Company.Division.Marketing extends MBAi.Company.Division.Division
{
    static TASK_MAKE_SUBSIDY_PROJECT = ::MBAi.Company.Division.Task.MakeSubsidyProject;

    function getName()
    {
        return "marketing";
    }

    function createTasksFromEvent(_event)
    {
        switch(_event.GetEventType()){
            case ::AIEvent.ET_SUBSIDY_OFFER:
                this.addTask(this.TASK_MAKE_SUBSIDY_PROJECT.createTask(::MBAi.World.Subsidy(_event.GetSubsidyID())));
                break;
        }
    }

    function createTasks()
    {

    }

    function getTasksOperations()
    {
        return [
            ::MBAi.Company.Division.Task.MakeSubsidyProject(this.company)
        ];
    }
}