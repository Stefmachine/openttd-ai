MachineBoiAi <- {}

class Autoloader
{
    static loaded = {};

    // FQCN - Fully Qualified Class Name. Ex: MachineBoiAi.Namespace.Class
    function load(_fqcn)
    {
        local fqcnParts = Autoloader.splitFqcn(_fqcn);

        local namespace = MachineBoiAi;
        foreach(index, name in fqcnParts) {
            if (name != "MachineBoiAi") {
                if (!(name in namespace)) {
                    namespace[name] <- {};
                    if (index == fqcnParts.len() - 1) {
                        require(Autoloader.fqcnToPath(_fqcn));
                    }
                }

                namespace = namespace[name];
            }
        }

        return namespace;
    }

    function splitFqcn(_fqcn)
    {
        local fqcnParts = [];
        for (local index = _fqcn.find("."); index != null; index = _fqcn.find(".")) {
            fqcnParts.append(_fqcn.slice(0, index));
            _fqcn = _fqcn.slice(index + 1);
        }
        fqcnParts.append(_fqcn);
        return fqcnParts;
    }

    function fqcnToPath(_fqcn)
    {
        local fqcnParts = Autoloader.splitFqcn(_fqcn);
        local path = "";
        foreach(index, value in fqcnParts) {
            path += (value == "MachineBoiAi" ? "src" : value);
            if (index != fqcnParts.len() - 1) {
                path += "/";
            }
        }
        return path + ".nut";
    }
}

function using(_class)
{
    return Autoloader.load(_class);
}