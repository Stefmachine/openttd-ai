using("MBAi.Data.DataStore.Storable");

class MBAi.Company.Project.Project extends MBAi.Data.DataStore.Storable
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