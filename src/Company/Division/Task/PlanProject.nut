using("MBAi.Company.Division.Task.TaskExecution");

class MBAi.Company.Division.Task.PlanProject extends MBAi.Company.Division.Task.TaskExecution
{
    static id = "plan_project";
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
            this.fail("Cannot evaluate feasibility of project that doesn't exist.");
        }

        project.setActionState("feasible", true);
        project.setActionState("cost", 200000);
        project.setActionState("build_plan", []);

        return true;
    }

    // STATIC
    function createTask(_project)
    {
        return ::MBAi.Company.Division.Task.TaskExecution.createTask(
            ::MBAi.Company.Division.Task.PlanProject.id,
            {projectId = _project.id}
        );
    }
}