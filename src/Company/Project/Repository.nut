using("MBAi.Data.StorableRepository");
using("MBAi.Company.Project.Project");

class MBAi.Company.Project.Repository extends MBAi.Data.StorableRepository
{
    function getStorableClass()
    {
        return ::MBAi.Company.Project.Project;
    }
}