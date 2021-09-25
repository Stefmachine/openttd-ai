using("MBAi.World.Abstract.Model");

class MBAi.World.Industry extends MBAi.World.Abstract.Model
{
    function getApi()
    {
        return ::AIIndustry;
    }

    function getModelName()
    {
        return "industry";
    }

    function isValid()
    {
        return this.getApi().IsValidIndustry(this.id);
    }
}

class MBAi.World.Industry.Repository extends MBAi.World.Abstract.ModelRepository
{
    function getModelClass()
    {
        return ::MBAi.World.Industry;
    }

    function getListApi()
    {
        return ::AIIndustryList;
    }
}