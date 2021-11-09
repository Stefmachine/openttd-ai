using("MBAi.Company.Division.Task.TaskExecution");

class MBAi.Company.Division.Task.BuildProject extends MBAi.Company.Division.Task.TaskExecution
{
    static id = "build_project";
    companyManager = null;

    constructor(_companyManager)
    {
        this.companyManager = _companyManager;
    }

    function execute(_task)
    {
        local project = this.companyManager.projects.findById(_task.getInfo("projectId"));
        if(project == null){
            this.fail("Cannot build project that doesn't exist.");
        }

        return this.done();
    }

    // STATIC
    function createTask(_project)
    {
        return ::MBAi.Company.Division.Task.TaskExecution.createTask(
            ::MBAi.Company.Division.Task.BuildProject.id,
            {projectId = _project.id}
        );
    }
}