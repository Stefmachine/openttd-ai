using("MBAi.Utils.Array");
using("MBAi.Data.Store");
using("MBAi.Common.AbstractClass");

class MBAi.Data.Storable extends MBAi.Common.AbstractClass
{
    __id = null;

    constructor()
    {
        this.ensureSlotImplementation("getStorageKey", "MBAi.Data.Storable");
        this.__id = null;
        this.getStorageKey();
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
            return ::MBAi.Utils.Array.indexOf(this.getStorage().id, this.__id);
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