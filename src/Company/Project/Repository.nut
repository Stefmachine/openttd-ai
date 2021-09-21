local DataStore = using("MBAi.Data.DataStore");
local Project = using("MBAi.Company.Project.Project");
local Utils = using("MBAi.Utils");

class MBAi.Company.Project.Repository
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
            DataStore.transaction(function(_data, _project){
                local projectDataStore = _data.projects
                local id = projectDataStore.__meta.nextId++;
                projectDataStore.id.push(id);
                projectDataStore.evaluation.push(_project.evaluation);
                projectDataStore.targets.push(_project.targets);
                projectDataStore.destinationTiles.push(_project.destinationTiles);
                _project.__id = id;
            }, _project);
        }
    }

    function remove(_project)
    {
        if(_project instanceof Project && _project.id != null){
            DataStore.transaction(function(_data, _project){
                local projectDataStore = _data.projects
                local index = _project.index;
                foreach (column in projectDataStore.__meta.columns) {
                    projectDataStore[column].remove(index);
                }
                _project.__id = null;
            }, _project);
        }
    }
}