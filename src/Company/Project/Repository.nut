local DataStore = using("MachineBoiAi.Data.DataStore");
local Project = using("MachineBoiAi.Company.Project.Project");
local Utils = using("MachineBoiAi.Utils");

class MachineBoiAi.Company.Project.Repository
{
    static Project = Project;
    static DataStore = DataStore;
    static Utils = Utils;

    function findById(_id)
    {
        if(this.Utils.Array.indexOf(DataStore.data.projects.id, _id) > -1){
            local project = Project();
            project.__id = _id;
            return project; // Storable are linked directly to store
        }
        return null;
    }

    function add(_project)
    {
        if(_project instanceof Project && _project.id == null){
            DataStore.transaction(function(_data):(_project){
                local projectDataStore = _data.projects
                local id = projectDataStore.__meta.nextId++;
                projectDataStore.id.push(id);
                projectDataStore.evaluation.push(_project.evaluation);
                projectDataStore.targets.push(_project.targets);
                projectDataStore.destinationTiles.push(_project.destinationTiles);
                _project.__id = id;
            });
        }
    }
}