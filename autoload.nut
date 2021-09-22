MBAi <- {};

class Autoloader
{
    static loaded = {};
    static namespaces = {
        MBAi = {
            ref = ::MBAi
            dir = "src"
        }
    }

    // FQCN - Fully Qualified Class Name. Ex: MBAi.Namespace.Class
    function load(_fqcn)
    {
        local fqcnParts = Autoloader.splitFqcn(_fqcn);

        fqcnParts.reverse();
        local baseNamespace = fqcnParts.pop();
        fqcnParts.reverse();

        local namespace = Autoloader.namespaces[baseNamespace].ref;
        local accFqcn = baseNamespace;
        foreach(index, name in fqcnParts) {
            accFqcn += "."+name
            if (!(name in namespace)) {
                try {
                    require(Autoloader.fqcnToPath(accFqcn));
                } catch (ex){/* Silently fail */}
            }

            if(!(name in namespace)){
                if(index == fqcnParts.len() - 1){
                    throw "Could not resolve "+_fqcn+".";
                }
                namespace[name] <- {};
            }

            namespace = namespace[name];
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

        fqcnParts.reverse();
        local baseDirectory = Autoloader.namespaces[fqcnParts.pop()].dir;
        fqcnParts.reverse();

        local path = baseDirectory + "/";
        foreach(index, value in fqcnParts) {
            path += value;
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