using("MBAi.Company.Division.Task.TaskExecution");
using("MBAi.World.Subsidy");
using("MBAi.Company.Project.Project");

class MBAi.Company.Division.Task.MakeSubsidyProject extends MBAi.Company.Division.Task.TaskExecution
{
    static id = "make_subsidy_project";
    companyManager = null;

    constructor(_companyManager)
    {
        this.companyManager = _companyManager;
    }

    function execute(_task)
    {
        local subsidy = ::MBAi.World.Subsidy(_task.getInfo("subsidyId"));
        if(subsidy.isValid() && !subsidy.isAwarded()){
            local source = subsidy.getSource();
            local destination = subsidy.getDestination();

            if(source.isValid() && destination.isValid()){
                local project = ::MBAi.Company.Project.Project();
                project.addTarget(source);
                project.addTarget(destination);

                this.companyManager.projects.add(project);
                ::MBAi.Logger.debug("Created project(#{pid}) from subsidy(#{sid}).", {pid = project.id, sid = subsidy.id});

                this.companyManager.admin.addTask(this.companyManager.admin.TASK_MANAGE_PROJECT.createTask(project));
                return true;
            }

            this.fail("Failed to create project from subsidy(#{sid}) as the source and/or destination is invalid.", {sid = subsidy.id});
        }

        this.fail("Failed to create project from subsidy(#{sid}) as the subsidy is invalid or already awarded.", {sid = subsidy.id});
    }

    // STATIC
    function createTask(_subsidy)
    {
        return ::MBAi.Company.Division.Task.TaskExecution.createTask(
            ::MBAi.Company.Division.Task.MakeSubsidyProject.id,
            {subsidyId = _subsidy.id}
        );
    }
}