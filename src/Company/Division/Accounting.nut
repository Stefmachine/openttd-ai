using("MBAi.Company.Division.Division");
using("MBAi.Company.Division.Task.UnlockProjectBudget");

class MBAi.Company.Division.Accounting extends MBAi.Company.Division.Division
{
    static TASK_UNLOCK_PROJECT_BUDGET = ::MBAi.Company.Division.Task.UnlockProjectBudget;

    function getName()
    {
        return "accounting";
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
            this.TASK_UNLOCK_PROJECT_BUDGET(this.company)
        ];
    }
}