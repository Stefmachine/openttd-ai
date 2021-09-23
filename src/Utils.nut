class MBAi.Utils
{
    function deepClone(_container){
        // container must not have circular references
        switch(typeof(_container)){
            case "table":
                local result = clone _container;
                foreach( k,v in _container){
                    result[k] = ::MBAi.Utils.deepClone(v);
                }
                return result;
            case "array":
                return ::MBAi.Utils.Array.map(_container, function(_value, _index, _array){
                    return ::MBAi.Utils.deepClone(_value);
                });
            default:
                return _container;
        }
    }
}

class MBAi.Utils.Array
{
    function join(_array, _separator = "")
    {
        local string = "";
        foreach (index,value in _array) {
            string += value.tostring();
            if(index != _array.len() - 1){
                string += _separator;
            }
        }

        return string;
    }

    function indexOf(_array, _element)
    {
        foreach (index,value in _array) {
            if(value == _element){
                return index;
            }
        }

        return -1;
    }

    function map(_array, _mapFunction)
    {
        local mapped = [];
        foreach (index, value in _array) {
            mapped.push(_mapFunction(value, index, _array));
        }

        return mapped;
    }

    function filter(_array, _filterFunction)
    {
        local filtered = [];
        foreach (index, value in _array) {
            if(_filterFunction(value, index, _array)){
                filtered.push(value);
            }
        }

        return filtered;
    }
}

class MBAi.Utils.Statement
{
    function coalesce(...)
    {
        for (local i = 0; i < vargc; i++) {
            if(vargv[i] != null){
                return vargv[i];
            }
        }
        return null;
    }
}

class MBAi.Utils.String
{
    function split(_string, _separator = "")
    {
        local parts = [];
        if (_separator != "") {
            for (local index = _string.find(_separator); index != null; index = _string.find(_separator)) {
                parts.append(_string.slice(0, index));
                _string = _string.slice(index + _separator.len());
            }
            parts.append(_string);
        } else {
            for (local index = 0; index < _string.len(); index++) {
                parts.append(_string.slice(index, index));
            }
        }

        return parts;
    }

    function replace(_string, _search, _replacement)
    {
        return ::MBAi.Utils.Array.join(::MBAi.Utils.String.split(_string, _search), _replacement);
    }
}