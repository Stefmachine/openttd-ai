using("MBAi.Company.Division.Division");

class MBAi.Company.Division.Marketing extends MBAi.Company.Division.Division
{
    static TASK_EVALUATE_SUBSIDY = "evaluate_subsidy";

    function getName()
    {
        return "marketing";
    }

    function getTasksPriority()
    {
        return [
            ::MBAi.Company.Division.Marketing.TASK_EVALUATE_SUBSIDY
        ];
    }

    function createTasksFromEvent(_event)
    {
        switch(_event.GetEventType()){
            case ::AIEvent.ET_SUBSIDY_OFFER:
                local sameTask = MBAi.Utils.Array.find(this.getTasks(), function(_task, _index, _tasks):(_event){
                    return _task.type == ::MBAi.Company.Division.Marketing.TASK_EVALUATE_SUBSIDY && _event.GetSubsidyID() == _task.info.subsidyId;
                });
                if(sameTask == null){
                    this.addTask(::MBAi.Company.Division.Marketing.TASK_EVALUATE_SUBSIDY, {subsidyId = _event.GetSubsidyID()});
                }
                break;
        }
    }

    function createTasks()
    {

    }

    function realiseTask(_task)
    {

    }
}