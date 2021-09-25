using("MBAi.Company.Division.Division");
using("MBAi.World.Subsidy");
using("MBAi.Company.Task.Failure");

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

    function getTasksOperations()
    {
        local executionTasks = {};
        executionTasks[::MBAi.Company.Division.Marketing.TASK_MAKE_SUBSIDY_PROJECT] <- this.performMakeSubsidyProjectTask;
        return executionTasks;
    }

    function performMakeSubsidyProjectTask(_task)
    {
        local subsidy = ::MBAi.World.Subsidy(_task.info.subsidyId);
        if(subsidy.isValid() && !subsidy.isAwarded()){
            local source = subsidy.getSource();
            local destination = subsidy.getDestination();

            if(source.isValid() && destination.isValid()){
                local project = ::MBAi.Company.Project.Project();
                project.addTarget(source);
                project.addTarget(destination);

                this.company.projects.add(project);
                ::MBAi.Logger.debug("Created project(#{pid}) from subsidy(#{sid}).", {pid = project.id, sid = subsidy.id});

                return project;
            }

            throw ::MBAi.Company.Task.Failure("Failed to create project from subsidy(#{sid}) as the source and/or destination is invalid.", {sid = subsidy.id});
        }

        throw ::MBAi.Company.Task.Failure("Failed to create project from subsidy(#{sid}) as the subsidy is invalid or already awarded.", {sid = subsidy.id});
    }
}