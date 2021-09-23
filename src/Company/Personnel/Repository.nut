using("MBAi.Data.StorableRepository");
using("MBAi.Company.Personnel.Personnel");

class MBAi.Company.Personnel.Repository extends MBAi.Data.StorableRepository
{
    function getStorableClass()
    {
        return ::MBAi.Company.Personnel.Personnel;
    }
}