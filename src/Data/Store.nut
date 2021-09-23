using("MBAi.Utils");

class MBAi.Data.Store
{
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
            __meta = {
                nextId = 1
                columns = ["id", "division"]
            }
        }
    };

    function import(_version, _data)
    {
        ::MBAi.Data.Store.data <- _data;
    }

    function export()
    {
        return ::MBAi.Data.Store.data;
    }

    function transaction(_function)
    {
        local dataClone = ::MBAi.Utils.deepClone(::MBAi.Data.Store.data);
        _function(dataClone);
        ::AIController.Sleep(1);
        ::MBAi.Data.Store.data <- dataClone;
    }
}