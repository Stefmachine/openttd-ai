using("MBAi.Company.Division.Task.TaskExecution");

class MBAi.Company.Division.Task.EvaluateProjectCost extends MBAi.Company.Division.Task.TaskExecution
{
    static id = "evaluate_project_cost";
    companyManager = null;

    constructor(_companyManager)
    {
        this.companyManager = _companyManager;
    }

    function execute(_task)
    {
        local projectId = _task.getInfo("projectId");
        local project = this.companyManager.projects.findById(projectId);
        if(project == null){
            this.fail("Cannot evaluate cost of project that doesn't exist.");
        }

        return true;
    }

    // STATIC
    function createTask(_project)
    {
        return ::MBAi.Company.Division.Task.TaskExecution.createTask(
            ::MBAi.Company.Division.Task.EvaluateProjectCost.id,
            {projectId = _project.id}
        );
    }
}