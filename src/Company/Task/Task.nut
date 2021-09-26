using("MBAi.Data.Storable");
using("MBAi.Company.Division.Division");

class MBAi.Company.Task.Task extends MBAi.Data.Storable
{
    constructor()
    {
        ::MBAi.Data.Storable.constructor();
        this.division = ::MBAi.Company.Division.Division.DIVISION_ANY;
        this.assignedPersonnel = null;
        this.type = null;
        this.info = {};
    }

    function assignTo(_personnel)
    {
        this.assignedPersonnel = _personnel.id;
    }

    function unassign()
    {
        this.assignedPersonnel = null;
    }

    function setInfo(_name, _value)
    {
        this.info[_name] <- _value;
    }

    function getInfo(_name, _default = null)
    {
        return (_name in this.info) ? this.info[_name] : _default;
    }

    function getStorageKey()
    {
        return "tasks";
    }
}