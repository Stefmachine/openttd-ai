using("MBAi.Data.DataStore");
using("MBAi.Company.Project.Project");
using("MBAi.Utils");
using("MBAi.Logger");

class MBAi.Company.Project.Repository
{
    static Project = ::MBAi.Company.Project.Project;
    static DataStore = ::MBAi.Data.DataStore;
    static Utils = ::MBAi.Utils;
    static Logger = ::MBAi.Logger;

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

    function _nexti(_previousIndex)
    {
        local projectDataStore = DataStore.data.projects
        local nextIndex = (_previousIndex != null ? _previousIndex + 1 : 0);
        if(projectDataStore.id.len() > nextIndex){
            return nextIndex;
        }
        return null;
    }

    function _get(_index)
    {
        local projectDataStore = DataStore.data.projects
        if(typeof _index == "integer" && -1 < _index && _index < projectDataStore.id.len()){
            local project = Project();
            project.__id = projectDataStore.id[_index];
            return project;
        }

        throw "Index not '"+_index+"' found.";
    }
}