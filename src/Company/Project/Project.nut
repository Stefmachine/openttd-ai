using("MBAi.Data.Storable");

class MBAi.Company.Project.Project extends MBAi.Data.Storable
{
    static TARGET_TOWN = "town";
    static TARGET_INDUSTRY = "industry";

    constructor()
    {
        ::MBAi.Data.Storable.constructor();
        this.evaluation = null
        this.targets = []
        this.destinationTiles = []
    }

    function addTownTarget(_townId)
    {
        this.targets.push({
            type = ::MBAi.Company.Project.Project.TARGET_TOWN
            id = _townId
        });
    }

    function addIndustryTarget(_industryId)
    {
        this.targets.push({
            type = ::MBAi.Company.Project.Project.TARGET_INDUSTRY
            id = _industryId
        });
    }

    function getStorageKey()
    {
        return "projects";
    }
}