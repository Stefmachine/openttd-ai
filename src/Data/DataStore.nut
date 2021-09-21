using("MBAi.Utils");

class MBAi.Data.DataStore
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
                columns = ["id", "evaluation", "targets", "destinationTiles"]
            }
        }

        personnel = {
            id = []
            name = []
            gender = []
            division = []
            rank = []
            __meta = {
                nextId = 1
                columns = ["id", "name", "gender", "division", "rank"]
            }
        }
    };

    function import(_version, _data)
    {
        MBAi.Data.DataStore.data <- _data;
    }

    function export()
    {
        return MBAi.Data.DataStore.data;
    }

    function transaction(_function, ...)
    {
        local dataClone = MBAi.Utils.deepClone(MBAi.Data.DataStore.data);

        local args = [null, dataClone];
        for(local i = 0; i < vargc; i++){
            args.push(vargv[i]);
        }

        _function.acall(args);
        AIController.Sleep(1);
        MBAi.Data.DataStore.data <- dataClone;
    }
}

class MBAi.Data.DataStore.Storable
{
    static DataStore = MBAi.Data.DataStore;

    __id = null;

    constructor()
    {
        this.__id <- null;
    }

    function getStorageKey()
    {
        throw "getStorageKey must be implemented in child class of Storable.";
    }

    function getStorage()
    {
        return DataStore.data[this.getStorageKey()];
    }

    function _get(_prop)
    {
        if(_prop == "id"){
            return this.__id;
        }

        if(_prop == "index"){
            return MBAi.Utils.Array.indexOf(this.getStorage().id, this.__id);
        }

        local prop = "__"+_prop;
        if(prop in this){
            if(this.__id != null){
                return this.getStorage()[_prop][this.index];
            }
            else{
                return this[prop];
            }
        }

        throw "Property "+_prop+" not found in object.";
    };

    function _set(_prop, _value)
    {
        local prop = "__"+_prop;
        if(_prop == "id"){
            // Preventing ID update from direct setter (cuz I'm a big dumb dumb and I know I'll try it without knowing at some point)
            throw "Cannot not update the ID from setter.";
        }

        if(prop in this){
            if(this.__id != null && this.index > -1){
                this.getStorage()[_prop][this.index] = _value;
            }
            else{
                this[prop] = _value;
            }
            return;
        }

        throw "Property "+_prop+" named '"+prop+"' not found in object.";
    };
}