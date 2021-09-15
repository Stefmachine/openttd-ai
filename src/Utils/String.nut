using("MachineBoiAi.Utils.Array");

class MachineBoiAi.Utils.String
{
    static Utils = MachineBoiAi.Utils;

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
        local self = MachineBoiAi.Utils.String;

        return self.Utils.Array.join(self.split(_string, _search), _replacement);
    }
}