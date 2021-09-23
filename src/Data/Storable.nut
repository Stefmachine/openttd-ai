using("MBAi.Utils");
using("MBAi.Utils.Array");
using("MBAi.Data.Store");
using("MBAi.Common.AbstractClass");

class MBAi.Data.Storable extends MBAi.Common.AbstractClass
{
    __id = null;
    __data = {};

    constructor()
    {
        this.ensureSlotImplementation("getStorageKey", "MBAi.Data.Storable");
        this.getStorageKey();
        this.__id = null;
        this.__data = {};
        foreach (column in this.getStorage().__meta.columns) {
            this.__data[column] <- null;
        }
    }

    function getStorage()
    {
        return ::MBAi.Data.Store.data[this.getStorageKey()];
    }

    function _get(_prop)
    {
        if(_prop == "id"){
            return this.__id;
        }

        if(_prop == "index"){
            return ::MBAi.Utils.Array.indexOf(this.getStorage().id, this.id);
        }

        if(_prop in this.__data){
            if(this.index > -1){
                return this.getStorage()[_prop][this.index];
            }
            else{
                return this.__data[_prop];
            }
        }

        if(_prop in this){
            return this[_prop];
        }

        throw "Property "+_prop+" not found in object.";
    };

    function _set(_prop, _value)
    {
        if(_prop == "id"){
            // Preventing ID update from direct setter (cuz I'm a big dumb dumb and I know I'll try it without knowing at some point)
            throw "Cannot not update the ID from setter.";
        }

        if(_prop in this.__data){
            if(this.index > -1){
                this.getStorage()[_prop][this.index] = _value;
            }
            else{
                this.__data[_prop] = _value;
            }
            return;
        }

        throw "Property "+_prop+" not found in object.";
    };

    function _tostring()
    {
        local data = {};
        foreach (column in this.getStorage().__meta.columns) {
            data[column] <- this[column];
        }

        return ::MBAi.Utils.toDebugString(data);
    }
}