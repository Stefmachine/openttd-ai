using("MBAi.Company.Division.Task.TaskExecution");

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
        local projectId = _task.getInfo("projectId");
        local project = this.companyManager.projects.findById(projectId);
        if(project == null){
            this.fail("Cannot manage a project that doesn't exist.");
        }

        if(project.getActionState("feasible") == false){
            return true; // Task is done
        }

        if(project.getActionState("budget_unlocked") == false){
            return true; // Task is done
        }

        if(project.getActionState("feasible") == null){
            if(_task.getInfo("plan_task", false) == false){
                this.companyManager.logistics.addTask(this.companyManager.logistics.TASK_PLAN_PROJECT.createTask(project));
                _task.setInfo("plan_task", true);
            }
        }
        else if(project.getActionState("budget_unlocked") == null){
            if(_task.getInfo("unlock_budget_task", false) == false){
                this.companyManager.accounting.addTask(this.companyManager.accounting.TASK_UNLOCK_PROJECT_BUDGET.createTask(project));
                _task.setInfo("unlock_budget_task", true);
            }
        }
        else{
            if(_task.getInfo("build_task", false) == false){
                this.companyManager.logistics.addTask(this.companyManager.logistics.TASK_BUILD_PROJECT.createTask(project));
                _task.setInfo("build_task", true);
            }
        }

        if(!project.completed){
            return false;
        }

        return true;
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