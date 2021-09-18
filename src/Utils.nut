class MachineBoiAi.Utils
{
    function deepClone(container){
        // container must not have circular references
        switch(typeof(container)){
            case "table":
                local result = clone container;
                foreach( k,v in container){
                    result[k] = MachineBoiAi.Utils.deepClone(v);
                }
                return result;
            case "array":
                return MachineBoiAi.Utils.Array.map(container, MachineBoiAi.Utils.deepClone);
            default:
                return container;
        }
    }
}

class MachineBoiAi.Utils.Array
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
}

class MachineBoiAi.Utils.Statement
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

class MachineBoiAi.Utils.String
{
    function split(_string, _separator = "")
    {
        local parts = [];
        if (_separator != "") {
            for (local index = _string.find(_separator); index != null; index = _string.find(_separator)) {
                parts.append(_string.slice(0, index));
                _string = _string.slice(index + 1);
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
        return MachineBoiAi.Utils.Array.join(MachineBoiAi.Utils.String.split(_string, _search), _replacement);
    }
}