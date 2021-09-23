using("MBAi.Data.Storable")

class MBAi.Company.Task.Task extends MBAi.Data.Storable
{
    __division = null;

    constructor()
    {
        ::MBAi.Data.Storable.constructor();
        this.__division = null;
    }

    function getStorageKey()
    {
        return "tasks";
    }
}