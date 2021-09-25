using("MBAi.Data.Storable");
using("MBAi.Company.Division.Division");

class MBAi.Company.Personnel.Personnel extends MBAi.Data.Storable
{
    constructor()
    {
        ::MBAi.Data.Storable.constructor();
        this.name = null;
        this.gender = null;
        this.division = ::MBAi.Company.Division.Division.DIVISION_ANY;
        this.tasksDone = 0;
    }

    function getStorageKey()
    {
        return "personnel";
    }
}