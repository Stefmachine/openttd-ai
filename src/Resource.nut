using("MachineBoiAi.Utils");

class MachineBoiAi.Resource
{
    function loadResource(_id)
    {
        local idParts = MachineBoiAi.Utils.String.split(_id, ".");
        local table = MachineBoiAi.Resource;
        foreach(index, id in idParts) {
            if (!(id in table)) {
                table[id] <- {};
                if (index == idParts.len() - 1) {
                    require(MachineBoiAi.Resource.resourceIdToPath(_id));
                }
            }

            table = table[id];
        }

        return table;
    }

    function resourceIdToPath(_id)
    {
        return "../resources/" + MachineBoiAi.Utils.String.replace(_id, ".", "/") + ".en.nut";
    }
}