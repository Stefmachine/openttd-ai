using("MBAi.Utils.Array");

class MBAi.Common.Collection
{
    arrayData = [];

    constructor(_array)
    {
        this.arrayData = _array;
    }

    function findBy(_filterFunction, _sortFunction = null)
    {
        local data = this.toArray();
        if(_sortFunction != null){
            data.sort(_sortFunction);
        }
        return ::MBAi.Utils.Array.filter(data, _filterFunction)
    }

    function findOneBy(_filterFunction, _sortFunction = null)
    {
        local array = this.findBy(_filterFunction,_sortFunction);
        return array.len() > 0 ? array[0] : null;
    }

    function get(_index)
    {
        if(_index > -1 && _index < this.count()){
            return this.arrayData[_index];
        }

        return null;
    }

    function count()
    {
        return this.arrayData.len();
    }

    function add(_element)
    {
        this.arrayData.push(_element);
    }

    function remove(_index)
    {
        if(_index > -1 && _index < this.count()){
            this.arrayData.remove(_index);
        }
    }

    function toArray()
    {
        return ::MBAi.Utils.Array.map(this.arrayData, function(_element, _index, _array){
            return _element;
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