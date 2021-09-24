using("MBAi.Company.Division.Division");

class MBAi.Company.Division.Marketing extends MBAi.Company.Division.Division
{
    static TASK_MAKE_SUBSIDY_PROJECT = "make_subsidy_project";

    function getName()
    {
        return "marketing";
    }

    function getTasksPriority()
    {
        return [
            ::MBAi.Company.Division.Marketing.TASK_MAKE_SUBSIDY_PROJECT
        ];
    }

    function createTasksFromEvent(_event)
    {
        switch(_event.GetEventType()){
            case ::AIEvent.ET_SUBSIDY_OFFER:
                local sameTask = MBAi.Utils.Array.find(this.getTasks(), function(_task, _index, _tasks):(_event){
                    return _task.type == ::MBAi.Company.Division.Marketing.TASK_MAKE_SUBSIDY_PROJECT && _event.GetSubsidyID() == _task.info.subsidyId;
                });
                if(sameTask == null){
                    this.addTask(::MBAi.Company.Division.Marketing.TASK_MAKE_SUBSIDY_PROJECT, {subsidyId = _event.GetSubsidyID()});
                }
                break;
        }
    }

    function createTasks()
    {

    }

    function performTask(_task)
    {
        if(_task.type == ::MBAi.Company.Division.Makerting.TASK_MAKE_SUBSIDY_PROJECT){
            if(::AISubsidy.IsValidSubsidy(_task.info.subsidyId) && !::AISubsidy.IsAwarded(_task.info.subsidyId)){
                local project = MBAi.Company.Project.Project();
                switch(::AISubsidy.GetSourceType()){
                    case ::AISubsidy.SPT_TOWN:
                        project.addTownTarget(::AISubsidy.GetSourceIndex(_task.info.subsidyId));
                        break;
                    case ::AISubsidy.SPT_INDUSTRY:
                        project.addIndustryTarget(::AISubsidy.GetSourceIndex(_task.info.subsidyId));
                        break;
                }

                switch(::AISubsidy.GetDestinationType()){
                    case ::AISubsidy.SPT_TOWN:
                        project.addTownTarget(::AISubsidy.GetDestinationIndex(_task.info.subsidyId));
                        break;
                    case ::AISubsidy.SPT_INDUSTRY:
                        project.addIndustryTarget(::AISubsidy.GetDestinationIndex(_task.info.subsidyId));
                        break;
                }

                this.company.projects.add(project);
            }

            this.company.tasks.remove(_task);
        }

    }
}