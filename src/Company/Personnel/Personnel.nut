using("MBAi.Data.Storable");
using("MBAi.Company.Divisions.Division")

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

MBAi.Company.Personnel.generate <- function(){
    local gender = [::AICompany.GENDER_MALE, ::AICompany.GENDER_FEMALE][::AIBase.RandRange(2)];
    local namePool = ::MBAi.Resource.loadResource("company.personnel");
    local name = namePool[gender][::AIBase.RandRange(namePool[gender].len())];

    local personnel = ::MBAi.Company.Personnel.Personnel();
    personnel.name = name;
    personnel.gender = gender;

    return personnel;
}