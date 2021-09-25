using("MBAi.Utils");

class MBAi.Logger
{
    //static REPORT_LEVEL = (::AIController.GetSetting("LogDebug") == 0 ? 1 : 0);
    static REPORT_LEVEL = 0;
    static PRINT_TO_CONSOLE = ::AIController.GetSetting("UsePrint") == 1;

    static LEVEL = {
        DEBUG = 0
        INFO = 1
        WARNING = 2
        ERROR = 3
    }

    function debug(_message, _context = {})
    {
        ::MBAi.Logger.log(::MBAi.Logger.LEVEL.DEBUG, _message, _context);
    }

    function info(_message, _context = {})
    {
        ::MBAi.Logger.log(::MBAi.Logger.LEVEL.INFO, _message, _context);
    }

    function warn(_message, _context = {})
    {
        ::MBAi.Logger.log(::MBAi.Logger.LEVEL.WARNING, _message, _context);
    }

    function error(_message, _context = {})
    {
        ::MBAi.Logger.log(::MBAi.Logger.LEVEL.ERROR, _message, _context);
    }

    function log(_level, _message, _context = {})
    {
        if(::MBAi.Logger.REPORT_LEVEL > _level){
            return;
        }

        local message = ::MBAi.Logger.processMessage(_message, _context);
        switch (_level) {
            case ::MBAi.Logger.LEVEL.DEBUG:
                message = "DEBUG: "+message;
                break;
            case ::MBAi.Logger.LEVEL.INFO:
                message = "INFO: "+message;
                break;
            case ::MBAi.Logger.LEVEL.WARNING:
                message = "WARNING: "+message;
                break;
            case ::MBAi.Logger.LEVEL.ERROR:
                message = "ERROR: "+message;
                break;
            default:
                throw "Unknown logger LEVEL "+_level+".";
        }

        if(::MBAi.Logger.PRINT_TO_CONSOLE){
            ::print(message);
        }
        else{
            switch (_level) {
                case ::MBAi.Logger.LEVEL.DEBUG:
                case ::MBAi.Logger.LEVEL.INFO:
                    ::AILog.Info(message);
                    break;
                case ::MBAi.Logger.LEVEL.WARNING:
                    ::AILog.Warning(message);
                    break;
                case ::MBAi.Logger.LEVEL.ERROR:
                    ::AILog.Error(message);
                    break;
            }
        }
    }

    function processMessage(_message, _context)
    {
        local contextEmpty = true;
        foreach (key, value in _context) {
            contextEmpty = false;
            local replacementKey = "{"+key+"}";
            _message = ::MBAi.Utils.String.replace(_message, "{"+key+"}", ""+::MBAi.Utils.toDebugString(value));
        }

        return _message;
    }
}