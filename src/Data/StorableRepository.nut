using("MBAi.Utils.Array");
using("MBAi.Data.Store");
using("MBAi.Data.Storable");
using("MBAi.Common.AbstractClass");

class MBAi.Data.StorableRepository extends MBAi.Common.AbstractClass
{
    constructor()
    {
        this.ensureSlotImplementation("getStorableClass", "MBAi.Data.StorableRepository");
        if(!(this.getStorableClass().instance() instanceof ::MBAi.Data.Storable)){
            throw "StorableRepository must return class extending Storable.";
        }
    }

    function getStorageKey()
    {
        return this.getStorableClass().getStorageKey();
    }

    function findById(_id)
    {
        return this.get(::MBAi.Utils.Array.indexOf(::MBAi.Data.Store.data[this.getStorageKey()].id, _id));
    }

    function findBy(_filterFunction, _sortFunction = null)
    {
        local storables = this.toArray();
        if(_sortFunction != null){
            storables.sort(_sortFunction);
        }
        return ::MBAi.Utils.Array.filter(storables, _filterFunction)
    }

    function findOneBy(_filterFunction, _sortFunction = null)
    {
        local array = this.findBy(_filterFunction,_sortFunction);
        return array.len() > 0 ? array[0] : null;
    }

    function get(_index)
    {
        if(_index > -1 && _index < ::MBAi.Data.Store.data[this.getStorageKey()].id.len()){
            local storableInstance = this.getStorableClass()();
            storableInstance.__id = ::MBAi.Data.Store.data[this.getStorageKey()].id[_index];
            return storableInstance;
        }
        return null;
    }

    function count()
    {
        return ::MBAi.Data.Store.data[this.getStorageKey()].id.len();
    }

    function add(_storable)
    {
        if(_storable instanceof (this.getStorableClass()) && _storable.id == null){
            local id = ::MBAi.Data.Store.data[this.getStorageKey()].__meta.nextId++; // Increment ID after retrieving it
            foreach (column in ::MBAi.Data.Store.data[this.getStorageKey()].__meta.columns) {
                ::MBAi.Data.Store.data[this.getStorageKey()][column].push(column == "id" ? id : _storable[column]);
            }
            _storable.__id = id;
        }
    }

    function remove(_storable)
    {
        if(_storable instanceof (this.getStorableClass()) && _storable.index > -1){
            local index = _storable.index;
            foreach (column in ::MBAi.Data.Store.data[this.getStorageKey()].__meta.columns) {
                ::MBAi.Data.Store.data[this.getStorageKey()][column].remove(index);
            }
            _storable.__id = null;
        }
    }

    function toArray()
    {
        return ::MBAi.Utils.Array.map(::MBAi.Data.Store.data[this.getStorageKey()].id, function(_id, _index, _array){
            return this.get(_index);
        });
    }

    function _nexti(_previousIndex)
    {
        local nextIndex = _previousIndex != null ? _previousIndex + 1 : 0;
        if(::MBAi.Data.Store.data[this.getStorageKey()].id.len() > nextIndex){
            return nextIndex;
        }
        return null;
    }

    function _get(_index)
    {
        if(typeof _index == "integer"){
            return this.get(_index);
        }

        throw "Index '"+_index+"' not found.";
    }
}