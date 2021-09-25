using("MBAi.Company.Division.Division");
using("MBAi.Company.Division.Task.ManageProject");

class MBAi.Company.Division.Administration extends MBAi.Company.Division.Division
{
    static TASK_MANAGE_PROJECT = ::MBAi.Company.Division.Task.ManageProject;

    function getName()
    {
        return "admin";
    }

    function createTasksFromEvent(_event)
    {

    }

    function createTasks()
    {

    }

    function getTasksOperations()
    {
        return [
            ::MBAi.Company.Division.Task.ManageProject(this.company)
        ];
    }
}