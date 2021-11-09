using("MBAi.Company.Division.Task.TaskExecution");
using("MBAi.World.Town");
using("MBAi.Utils");
using("MBAi.Utils.Array");

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
        local project = this.companyManager.projects.findById(_task.getInfo("projectId"));
        if(project == null){
            this.fail("Cannot evaluate feasibility of project that doesn't exist.");
        }

        local cargoesMatchingTargets = this.getMatchingCargoes(project.getTargets());

        if(cargoesMatchingTargets.len() == 0){
            this.fail("No cargo matches any target.");
        }


        // Plan pathway to other destination evaluating if it's feasible and how much it costs


        return this.done();
    }

    function getMatchingCargoes(_targets) {
        if(_targets.len() == 0){
            this.fail("Project does not have any target and thus cannot be planned.");
        }
        else if(_targets.len() == 1 && !(_targets[0] instanceof ::MBAi.World.Town)){
            this.fail("Project have too few target for planning.");
        }

        local cargoesMatchingAnyTargets = [];
        foreach (targetIndex, target in _targets) {
            if(!target.isValid()){
                this.fail("One of the project's target is invalid.");
            }

            if(!(target instanceof ::MBAi.World.Town) && !(target instanceof ::MBAi.World.Industry)){
                this.fail("Project targets can only be industries and towns, {type} given.", {type = target.getModelName()});
            }

            if(::MBAi.Utils.implements({getCargoProduced = function(){}, getCargoAccepted = function(){}}, target)){
                // Do something to check if any target cargoes match others but not itself
                local producedCargoes = target.getCargoProduced();

                foreach (otherTargetIndex, otherTarget in _targets) {
                    // In case a project only has one target, it must consider itself as another target
                    if(targetIndex != otherTargetIndex || _targets.len() == 1){
                        local acceptedCargo = target.getCargoAccepted();
                        foreach (cargo in producedCargoes) {
                            local matchingCargo = ::MBAi.Utils.Array.find(producedCargoes, function(_cargo, _index, _cargoes):(cargo){
                                return _cargo.isSame(cargo);
                            });

                            if(matchingCargo != null){ // Found a cargo that is produced and accepted by two different places
                                cargoesMatchingAnyTargets.push(matchingCargo);
                            }
                        }
                    }
                }
            }
        }

        return ::MBAi.Utils.Array.unique(cargoesMatchingAnyTargets, function(_cargo, _index, _cargoes){
            return _cargo.id;
        });
    }

    function onFail(_task)
    {
        local project = this.companyManager.projects.findById(_task.getInfo("projectId"));
        if(project != null){
            project.setActionState("feasible", false);
            project.setActionState("cost", 0);
            project.setActionState("build_plan", {});
        }

        return this.done()
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