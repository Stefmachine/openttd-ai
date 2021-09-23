using("MBAi.Utils.String");

class MBAi.Resource
{
    static LOCALE = "en"

    function loadResource(_id)
    {
        local idParts = ::MBAi.Utils.String.split(_id, ".");
        local table = ::MBAi.Resource;
        foreach(index, id in idParts) {
            if (!(id in table)) {
                table[id] <- {};
                if (index == idParts.len() - 1) {
                    try {
                        require(::MBAi.Resource.resourceIdToPath(_id, ::MBAi.Resource.LOCALE));
                    } catch (exception){
                        require(::MBAi.Resource.resourceIdToPath(_id));
                    }
                }
            }

            table = table[id];
        }

        return table;
    }

    function resourceIdToPath(_id, _locale = "en")
    {
        return "../resources/" + ::MBAi.Utils.String.replace(_id, ".", "/") + "."+_locale+".nut";
    }
}