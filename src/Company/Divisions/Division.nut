using("MBAi.Utils.Array");
using("MBAi.Common.AbstractClass");

class MBAi.Company.Divisions.Division extends MBAi.Common.AbstractClass
{
    static DIVISION_ANY = "*";

    company = null

    constructor(_company)
    {
        this.company = _company;
        this.ensureSlotImplementation("getName", "MBAi.Company.Divisions.Division");
    }

    function getPersonnel()
    {
        return MBAi.Utils.Array.filter(this.company.personnel.toArray(), function(_person, _index, _personnel){
            return _person.division == this.getName() || _person.division == ::MBAi.Company.Divisions.Division.DIVISION_ANY;
        });
    }

    function addPersonnel(_personnel)
    {
        _personnel.division = this.getName();
    }
}