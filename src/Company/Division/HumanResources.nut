using("MBAi.Company.Division.Division");
using("MBAi.Company.Personnel.Personnel");
using("MBAi.Resource");
using("MBAi.Logger");

class MBAi.Company.Division.HumanResources extends MBAi.Company.Division.Division
{
    function getName()
    {
        return "hr";
    }

    function createTasksFromEvent(_event)
    {

    }

    function createTasks()
    {

    }

    function getTasksOperations()
    {
        return [

        ];
    }

    function hirePersonnel(_division = ::MBAi.Company.Division.Division.DIVISION_ANY)
    {

        local newPersonnel = ::MBAi.Company.Division.HumanResources.generatePersonnel();
        this.company.personnel.add(newPersonnel);
        this.movePersonnel(newPersonnel, _division);

        ::MBAi.Logger.debug("Hired {personnel}", {personnel=newPersonnel});

        return newPersonnel;
    }

    function movePersonnel(_personnel, _division)
    {
        if(_division != ::MBAi.Company.Division.Division.DIVISION_ANY){
            _division.addPersonnel(_personnel);
        }
        else{
            _personnel.division = ::MBAi.Company.Division.Division.DIVISION_ANY;
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
        name += " " + namePool.lastNames[::AIBase.RandRange(namePool.lastNames.len())];

        local personnel = ::MBAi.Company.Personnel.Personnel();
        personnel.name = name;
        personnel.gender = gender;

        return personnel;
    }
}