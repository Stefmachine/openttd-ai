using("MBAi.Company.Division.Division");
using("MBAi.World.Subsidy");
using("MBAi.Company.Division.Task.MakeSubsidyProject");
using("MBAi.Company.Division.Task.MakeProjectFromTargets");
using("MBAi.World.Town.Repository");
using("MBAi.Utils.Array");

class MBAi.Company.Division.Marketing extends MBAi.Company.Division.Division
{
    static TASK_MAKE_SUBSIDY_PROJECT = ::MBAi.Company.Division.Task.MakeSubsidyProject;
    static TASK_MAKE_PROJECT_FROM_TARGETS = ::MBAi.Company.Division.Task.MakeProjectFromTargets;

    function getName()
    {
        return "marketing";
    }

    function createTasksFromEvent(_event)
    {
        switch(_event.GetEventType()){
            case ::AIEvent.ET_SUBSIDY_OFFER:
                this.addTask(this.TASK_MAKE_SUBSIDY_PROJECT.createTask(::MBAi.World.Subsidy(_event.GetSubsidyID())));
                break;
        }
    }

    function createTasks()
    {
        if(this.company.projects.count() == 0){
            local towns = ::MBAi.World.Town.Repository();
            local targets = [];
            for (local i = 0; i < 2; i++) {
                local tries = 10;
                local town = null;
                local found = false;
                while(town == null && tries > 0){
                    tries--;
                    town = towns.get(::AIBase.RandRange(towns.count()));
                    MBAi.Logger.info("{town}", {town = (town ? town.getName() : town)});
                    found = ::MBAi.Utils.Array.find(targets, function(_target, _index, _targets):(town){
                        return _target.isSame(town);
                    }) != null;
                    if(found){
                        MBAi.Logger.info("found");
                        town = null;
                    }
                }

                if(town == null){
                    MBAi.Logger.error("Failed to find adequate targets in the given number of iterations.")
                }

                targets.push(town);
            }
            this.addTask(this.TASK_MAKE_PROJECT_FROM_TARGETS.createTask(targets));
        }
    }

    function getTasksOperations()
    {
        return [
            this.TASK_MAKE_SUBSIDY_PROJECT(this.company),
            this.TASK_MAKE_PROJECT_FROM_TARGETS(this.company)
        ];
    }
}