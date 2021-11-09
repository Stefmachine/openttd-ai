using("MBAi.Common.AbstractClass");

class MBAi.World.Abstract.ModelRepository extends MBAi.Common.AbstractClass
{
    constructor()
    {
        this.ensureSlotImplementation("getModelClass", "MBAi.World.Abstract.ModelRepository");
        this.ensureSlotImplementation("getListApi", "MBAi.World.Abstract.ModelRepository");
        if(!(this.getModelClass().instance() instanceof ::MBAi.World.Abstract.Model)){
            throw "'getModelClass' must return class extending MBAi.World.Abstract.Model.";
        }
    }

    function getList()
    {
        local list = this.getListApi();
        list.Valuate(function(_id){
            return _id;
        });
        list.Begin();
        return list;
    }

    function findById(_id)
    {
        return this.findOneBy(function(_worldObject, _index, _repository):(_id){
            return _worldObject.id == _id;
        });
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
        if(_index > -1 && _index < this.count()){
            return this.toArray()[_index];
        }

        return null;
    }

    function count()
    {
        return this.getList().Count();
    }

    function toArray()
    {
        local list = this.getList();
        return ::MBAi.Utils.Array.map(list, function(_id, _index, _list){
            return this.getModelClass()(_id); //Use ModelFactory and caching
        });
    }

    function _nexti(_previousIndex)
    {
        local nextIndex = _previousIndex != null ? _previousIndex + 1 : 0;
        if(this.count() > nextIndex){
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