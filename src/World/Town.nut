using("MBAi.World.Abstract.Model");

class MBAi.World.Town extends MBAi.World.Abstract.Model
{
    function getApi()
    {
        return ::AITown;
    }

    function getModelName()
    {
        return "town";
    }

    function isValid()
    {
        return this.getApi().IsValidTown(this.id);
    }
}

class MBAi.World.Town.Repository extends MBAi.World.Abstract.ModelRepository
{
    function getModelClass()
    {
        return ::MBAi.World.Town;
    }

    function getListApi()
    {
        return ::AITownList;
    }
}