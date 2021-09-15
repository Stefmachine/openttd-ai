using("MachineBoiAi.Utils.String");

class MachineBoiAi.DataStore
{
    static Utils = MachineBoiAi.Utils;
    static data = {
        company = {
            name = null
            president = {
                name = null
                gender = null
            }
        }
    };

    function import(_version, _data)
    {
        MachineBoiAi.DataStore.data <- _data;
    }

    function export()
    {
        return MachineBoiAi.DataStore.data;
    }
}