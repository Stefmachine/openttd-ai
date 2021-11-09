using("MBAi.Utils.String");

class MBAi.Resource
{
    static LOCALE = "en";
    static FALLBACK_LOCALE = "en";
    static cache = {};

    function loadResource(_id)
    {
        if(!(_id in ::MBAi.Resource.cache)){
            local extensions = [null, ::MBAi.Resource.LOCALE, ::MBAi.Resource.FALLBACK_LOCALE];
            local found = false;
            foreach (extension in extensions) {
                if(!found){
                    try {
                        require(::MBAi.Resource.resourceIdToPath(_id, extension));
                        found = true;
                    } catch (ex){}
                }
            }
        }

        if(!(_id in ::MBAi.Resource.cache)){
            throw "Could not load resource with id '"+_id+"'";
        }

        return ::MBAi.Resource.cache[_id];
    }

    function register(_id, _resource)
    {
        ::MBAi.Logger.debug("Registering resource "+_id);
        ::MBAi.Resource.cache[_id] <- _resource;
    }

    function resourceIdToPath(_id, _extension = null)
    {
        return "../resources/" + ::MBAi.Utils.String.replace(_id, ".", "/") + (_extension != null ? "."+_extension : "") +".nut";
    }
}