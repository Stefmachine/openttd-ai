using("MBAi.Data.Storable");
using("MBAi.Company.Divisions.Division");

class MBAi.Company.Personnel.Personnel extends MBAi.Data.Storable
{
    __name = null;
    __gender = null;
    __division = null;

    constructor()
    {
        ::MBAi.Data.Storable.constructor();
        this.__name = null;
        this.__gender = null;
        this.__division = ::MBAi.Company.Divisions.Division.DIVISION_ANY;
    }

    function getStorageKey()
    {
        return "personnel";
    }
}