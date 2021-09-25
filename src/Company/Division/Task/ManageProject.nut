using("MBAi.Company.Division.Task.TaskExecution");
using("MBAi.Company.Project.Project");

class MBAi.Company.Division.Task.ManageProject extends MBAi.Company.Division.Task.TaskExecution
{
    static id = "manage_project";
    companyManager = null;

    constructor(_companyManager)
    {
        this.companyManager = _companyManager;
    }

    function execute(_task)
    {
        local projectId = _task.info.projectId;
        local project = this.companyManager.projects.findById(projectId);
        if(project == null){
            this.fail("Cannot manage a project that doesn't exist.");
        }

        if(!project.completed){
            this.companyManager.admin.addTask(this.createTask(project));
        }
    }

    // STATIC
    function createTask(_project)
    {
        return ::MBAi.Company.Division.Task.TaskExecution.createTask(
            ::MBAi.Company.Division.Task.ManageProject.id,
            {projectId = _project.id}
        );
    }
}