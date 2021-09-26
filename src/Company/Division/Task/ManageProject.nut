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

        if(project.getActionState("feasibility_evaluation") == false){
            return true; // Task is done
        }

        if(project.getActionState("budget_unlocked") == false){
            return true; // Task is done
        }

        if(project.getActionState("feasibility_evaluation") == null){
            if(_task.getInfo("feasibility_evaluation_task", false) == false){
                this.companyManager.logistics.addTask(::MBAi.Company.Division.Task.EvaluateProjectFeasibility.createTask(project));
                _task.setInfo("feasibility_evaluation_task", true);
            }
        }
        else if(project.getActionState("cost_evaluation") == null){
            if(_task.getInfo("cost_evaluation_task", false) == false){
                this.companyManager.logistics.addTask(::MBAi.Company.Division.Task.EvaluateProjectCost.createTask(project));
                _task.setInfo("cost_evaluation_task", true);
            }
        }
        else if(project.getActionState("budget_unlocked") == null){
            if(_task.getInfo("budget_unlock_task", false) == false){
                this.companyManager.accounting.addTask(::MBAi.Company.Division.Task.UnlockBudget.createTask(project));
                _task.setInfo("budget_unlock_task", true);
            }
        }
        else{
            if(_task.getInfo("build_task", false) == false){
                this.companyManager.logistics.addTask(::MBAi.Company.Division.Task.BuildProject.createTask(project));
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