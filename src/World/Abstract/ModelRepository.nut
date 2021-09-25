using("MBAi.Common.AbstractClass");

class MBAi.World.Abstract.ModelRepository extends MBAi.Common.AbstractClass
{
    list = null;

    constructor()
    {
        this.ensureSlotImplementation("getModelClass", "MBAi.World.Abstract.ModelRepository");
        this.ensureSlotImplementation("getListApi", "MBAi.World.Abstract.ModelRepository");
        if(!(this.getModelClass().instance() instanceof ::MBAi.World.Abstract.Model)){
            throw "'getModelClass' must return class extending MBAi.World.Abstract.Model.";
        }
        this.refresh();
    }

    function refresh()
    {
        this.list = this.getListApi()();
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
        local list = this.listApi();
        if(list.HasItem(_index)){
            return this.getWorldClass()(list.GetValue(_index));
        }
        return null;
    }

    function count()
    {
        return this.listApi().Count();
    }

    function toArray()
    {
        return ::MBAi.Utils.Array.map(this.listApi(), function(_id, _index, _list){
            return this.get(_index);
        });
    }

    function _nexti(_previousIndex)
    {
        local nextIndex = _previousIndex != null ? _previousIndex + 1 : 0;
        if(this.listApi().HasItem(nextIndex)){
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