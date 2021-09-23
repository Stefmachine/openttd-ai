using("MBAi.Company.Divisions.Division");
using("MBAi.Company.Personnel.Personnel");
using("MBAi.Resource");

class MBAi.Company.Divisions.HumanResources extends MBAi.Company.Divisions.Division
{
    function getName()
    {
        return "hr";
    }

    function assignTasks()
    {

    }

    function carryOutTasks()
    {

    }

    function hirePersonnel(_division = ::MBAi.Company.Divisions.Division.DIVISION_ANY)
    {

        local newPersonnel = ::MBAi.Company.Divisions.HumanResources.generatePersonnel();
        this.company.personnel.add(newPersonnel);
        this.movePersonnel(newPersonnel, _division);
        return newPersonnel;
    }

    function movePersonnel(_personnel, _division)
    {
        if(_division != ::MBAi.Company.Divisions.Division.DIVISION_ANY){
            _division.addPersonnel(_personnel);
        }
        else{
            _personnel.division = ::MBAi.Company.Divisions.Division.DIVISION_ANY;
        }
    }

    function firePersonnel(_personnel)
    {
        this.company.personnel.remove(_personnel);
    }

    // TO BE USED AS STATIC
    function generatePersonnel()
    {
        local gender = [::AICompany.GENDER_MALE, ::AICompany.GENDER_FEMALE][::AIBase.RandRange(2)];
        local namePool = ::MBAi.Resource.loadResource("company.personnel");
        local name = namePool[gender][::AIBase.RandRange(namePool[gender].len())];

        local personnel = ::MBAi.Company.Personnel.Personnel();
        personnel.name = name;
        personnel.gender = gender;

        return personnel;
    }
}