using("MBAi.Data.Storable");

class MBAi.Company.Project.Project extends MBAi.Data.Storable
{
    constructor()
    {
        ::MBAi.Data.Storable.constructor();
        this.evaluation = null
        this.targets = []
        this.destinationTiles = []
    }

    function getStorageKey()
    {
        return "projects";
    }
}