using("MBAi.Data.Storable");

class MBAi.Company.Project.Project extends MBAi.Data.Storable
{
    __evaluation = null
    __targets = []
    __destinationTiles = []

    constructor(){
        ::MBAi.Data.Storable.constructor();
        this.__evaluation = null
        this.__targets = []
        this.__destinationTiles = []
    }

    function getStorageKey()
    {
        return "projects";
    }
}