using("Utils/StringHelper")

class ResourceManager {
    static loadedResources = {};

    function loadResource(_id) {
        local idParts = StringHelper.split(_id, ".");
        local table = ResourceManager;
        foreach(index, id in idParts) {
            if (!(id in table)) {
                table[id] <- {};
                if (index == idParts.len() - 1) {
                    require("../../resources/" + ResourceManager.resourceIdToPath(_id) + ".en.nut");
                }
            }

            table = table[id];
        }

        return table;
    }

    function resourceIdToPath(_id) {
        return StringHelper.replace(_id, ".", "/");
    }
}