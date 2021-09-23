using("MBAi.Company.Divisions.Division");

class MBAi.Company.Divisions.Marketing extends MBAi.Company.Divisions.Division
{
    function getName()
    {
        return "marketing";
    }

    function assignTasks()
    {

    }

    function carryOutTasks()
    {

    }

    function findDemands()
    {
        ::AISubsidyList();
    }
}