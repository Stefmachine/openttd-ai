using("MachineBoiAi.Utils");

class MachineBoiAi.Data.DataStore
{
    static data = { // Never keep reference to data as it will be replaced often
        company = {
            name = null
            president = {
                name = null
                gender = null
            }
        }

        projects = { // DB like storage
            id = []
            evaluation = []
            targets = []
            destinationTiles = []
            __meta = {
                nextId = 1
            }
        }
    };

    function import(_version, _data)
    {
        MachineBoiAi.Data.DataStore.data <- _data;
    }

    function export()
    {
        return MachineBoiAi.Data.DataStore.data;
    }

    function transaction(_function)
    {
        local dataClone = MachineBoiAi.Utils.deepClone(MachineBoiAi.Data.DataStore.data);
        _function(dataClone)
        AIController.Sleep(1);
        MachineBoiAi.Data.DataStore.data <- dataClone;
    }


    // Storable composition API
    function composeStorable(_class)
    {
        if(!("storageKey" in _class)){
            throw "Static property storageKey must be declared in Storable composed class.";
        }

        _class.__id <- null;

        _class._set <- function(_prop, _value) {
            local prop = "__"+_prop;
            if(_prop == "id"){
                throw "Cannot not update the ID from setter.";
            }

            if(prop in this){
                if(this.__id != null && this.index > -1){
                    ::MachineBoiAi.Data.DataStore.data[this.storageKey][_prop][this.index] = _value;
                }
                else{
                    ::AILog.Warning("Setting "+prop);
                    this[prop] = _value;
                }
                return;
            }

            throw "Property "+_prop+" named '"+prop+"' not found in object.";
        };

        _class._get <- function(_prop) {
            if(_prop == "id"){
                return this.__id;
            }

            if(_prop == "index"){
                local index = ::MachineBoiAi.Utils.Array.indexOf(::MachineBoiAi.Data.DataStore.data[this.storageKey], this.id);
                return ::MachineBoiAi.Data.DataStore.data[this.storageKey].id[index];
            }

            local prop = "__"+_prop;
            if(prop in this){
                if(this.__id != null){
                    ::AILog.Warning("Getting "+_prop+"");
                    return ::MachineBoiAi.Data.DataStore.data[this.storageKey][_prop][this.index];
                }
                else{
                    ::AILog.Warning("Getting "+_prop);
                    return this[prop];
                }
            }

            throw "Property "+_prop+" not found in object.";
        };

        return _class;
    }
}