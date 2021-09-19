using("MachineBoiAi.Utils");
using("MachineBoiAi.Data.DataStore");

class MachineBoiAi.Company.Project.Project
{
    __evaluation = null
    __targets = []
    __destinationTiles = []

    constructor(){
        this.__evaluation = null
        this.__targets = []
        this.__destinationTiles = []
    }
}
MachineBoiAi.Data.DataStore.composeStorable(MachineBoiAi.Company.Project.Project, "projects");