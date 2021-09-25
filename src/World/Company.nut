using("MBAi.World.Abstract.Model");

class MBAi.World.Company extends MBAi.World.Abstract.Model
{
    function getApi()
    {
        return ::AICompany;
    }

    function getModelName()
    {
        return "company";
    }

    function isValid()
    {
        return this.getApi().ResolveCompanyID(this.id) != this.getApi().COMPANY_INVALID;
    }
}

class MBAi.World.Company.Repository extends MBAi.World.Abstract.ModelRepository
{
    function getModelClass()
    {
        return ::MBAi.World.Company;
    }

    function getListApi()
    {
        return ::AICompanyList;
    }
}