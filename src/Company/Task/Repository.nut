using("MBAi.Data.StorableRepository");
using("MBAi.Company.Task.Task");

class MBAi.Company.Task.Repository extends MBAi.Data.StorableRepository
{
    function getStorableClass()
    {
        return ::MBAi.Company.Task.Task;
    }
}