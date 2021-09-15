using("MachineBoiAi.Utils.String");

class MachineBoiAi.Resources.ResourceManager
{
    static Utils = MachineBoiAi.Utils;

    function loadResource(_id)
    {
        local self = MachineBoiAi.Resources.ResourceManager;

        local idParts = self.Utils.String.split(_id, ".");
        local table = self;
        foreach(index, id in idParts) {
            if (!(id in table)) {
                table[id] <- {};
                if (index == idParts.len() - 1) {
                    require(self.resourceIdToPath(_id));
                }
            }

            table = table[id];
        }

        return table;
    }

    function resourceIdToPath(_id)
    {
        local self = MachineBoiAi.Resources.ResourceManager;

        return "../../resources/" + self.Utils.String.replace(_id, ".", "/") + ".en.nut";
    }
}