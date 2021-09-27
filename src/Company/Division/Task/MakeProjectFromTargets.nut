using("MBAi.Company.Division.Task.TaskExecution");
using("MBAi.World.ModelFactory");
using("MBAi.Utils.Array");
using("MBAi.Company.Project.Project");

class MBAi.Company.Division.Task.MakeProjectFromTargets extends MBAi.Company.Division.Task.TaskExecution
{
    static id = "make_project_from_targets";
    companyManager = null;

    constructor(_companyManager)
    {
        this.companyManager = _companyManager;
    }

    function execute(_task)
    {
        local targets = ::MBAi.Utils.Array.map(_task.getInfo("targets"), function(_target, _index, _targets){
            return ::MBAi.World.ModelFactory.createModel(_target.type, _target.id);
        });

        local project = ::MBAi.Company.Project.Project();
        foreach (target in targets) {
            if(target.isValid()){
                project.addTarget(target);
            }
            else{
                this.fail("Failed to create project from targets as one of them is invalid.");
            }
        }

        this.companyManager.projects.add(project);
        ::MBAi.Logger.debug("Created project(#{pid}) from target list.", {pid = project.id});
        this.companyManager.admin.addTask(this.companyManager.admin.TASK_MANAGE_PROJECT.createTask(project));
        return true;
    }

    // STATIC
    function createTask(_targets)
    {
        return ::MBAi.Company.Division.Task.TaskExecution.createTask(
            ::MBAi.Company.Division.Task.MakeProjectFromTargets.id,
            {
                targets = MBAi.Utils.Array.map(_targets, function(_target, _index, _targets){
                    return _target.toData();
                })
            }
        );
    }
}