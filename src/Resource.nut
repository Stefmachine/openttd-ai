using("MBAi.Utils.String");

class MBAi.Resource
{
    function loadResource(_id)
    {
        local idParts = ::MBAi.Utils.String.split(_id, ".");
        local table = ::MBAi.Resource;
        foreach(index, id in idParts) {
            if (!(id in table)) {
                table[id] <- {};
                if (index == idParts.len() - 1) {
                    require(::MBAi.Resource.resourceIdToPath(_id));
                }
            }

            table = table[id];
        }

        return table;
    }

    function resourceIdToPath(_id)
    {
        return "../resources/" + ::MBAi.Utils.String.replace(_id, ".", "/") + ".en.nut";
    }
}