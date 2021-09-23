using("MBAi.Utils");

class MBAi.Data.Store
{
    static __buffer = null;
    static data = { // Never keep reference to data as it will be replaced often
        company = {
            name = null
            president = null
        }

        projects = {
            id = []
            evaluation = []
            targets = []
            destinationTiles = []
            __meta = {
                nextId = 1
                columns = ["id", "evaluation", "targets", "destinationTiles"]
            }
        }

        personnel = {
            id = []
            name = []
            gender = []
            division = []
            __meta = {
                nextId = 1
                columns = ["id", "name", "gender", "division"]
            }
        }

        tasks = {
            id = []
            division = []
            assignedPersonnel = []
            type = []
            info = []
            __meta = {
                nextId = 1
                columns = ["id", "division", "assignedPersonnel", "type", "info"]
            }
        }
    };

    function import(_version, _data)
    {
        ::MBAi.Data.Store.data <- _data;
    }

    function export()
    {
        if(::MBAi.Data.Store.__buffer != null){
            // Currently in a transaction export data before transaction
            // because we don't want to save mid-operation data and cause corruption
            return ::MBAi.Data.Store.__buffer;
        }

        return ::MBAi.Data.Store.data;
    }

    function transaction(_function)
    {
        local alreadyInTransaction = ::MBAi.Data.Store.__buffer != null;
        ::MBAi.Data.Store.__buffer <- ::MBAi.Utils.deepClone(::MBAi.Data.Store.data);
        _function();
        if(!alreadyInTransaction){
            ::AIController.Sleep(1); // Safest way to save is after a Sleep
            ::MBAi.Data.Store.__buffer <- null;
        }
    }
}