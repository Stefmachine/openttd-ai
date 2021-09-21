class MBAi.Logger
{
    static REPORT_LEVEL = 0;

    static LEVEL = {
        DEBUG = 0
        INFO = 1
        WARNING = 2
        ERROR = 3
    }

    function debug(_message, _context = {})
    {
        MBAi.Logger.log(MBAi.Logger.LEVEL.DEBUG, _message, _context);
    }

    function info(_message, _context = {})
    {
        MBAi.Logger.log(MBAi.Logger.LEVEL.INFO, _message, _context);
    }

    function warn(_message, _context = {})
    {
        MBAi.Logger.log(MBAi.Logger.LEVEL.WARNING, _message, _context);
    }

    function error(_message, _context = {})
    {
        MBAi.Logger.log(MBAi.Logger.LEVEL.ERROR, _message, _context);
    }

    function log(_level, _message, _context = {})
    {
        if(MBAi.Logger.REPORT_LEVEL > _level){
            return;
        }

        local message = MBAi.Logger.processMessage(_message, _context);
        switch (_level) {
            case MBAi.Logger.LEVEL.DEBUG:
                AILog.Info("DEBUG: "+message);
                break;
            case MBAi.Logger.LEVEL.INFO:
                AILog.Info("INFO: "+message);
                break;
            case MBAi.Logger.LEVEL.WARNING:
                AILog.Warning("WARNING: "+message);
                break;
            case MBAi.Logger.LEVEL.ERROR:
                AILog.Error("ERROR: "+message);
                break;
            default:
                throw "Unknown logger LEVEL "+_level+".";
        }
    }

    function processMessage(_message, _context)
    {
        local contextEmpty = true;
        foreach (key, value in _context) {
            contextEmpty = false;
            local replacementKey = "{"+key+"}";
            _message = MBAi.Utils.String.replace(_message, "{"+key+"}", ""+MBAi.Logger.convertToString(value));
        }

        return _message + (!contextEmpty ? "  " + MBAi.Logger.convertToString(_context) : "");
    }

    function convertToString(_data)
    {
        switch(typeof(_data)){
            case "table":
                local values = [];
                foreach(k, v in _data){
                    values.push(k+": "+MBAi.Logger.convertToString(v));
                }
                return "{"+MBAi.Utils.Array.join(values, ", ")+"}";
            case "array":
                return "["+MBAi.Utils.Array.join(MBAi.Utils.Array.map(_data, MBAi.Logger.convertToString), ", ")+"]";
            case "bool":
                return _data ? "true" : "false";
            case "integer":
            case "float":
                return ""+_data;
            case "string":
                return "\""+_data+"\"";
            case "null":
                return "null";
            default:
                return "_"+typeof _data+"_";
        }
    }
}