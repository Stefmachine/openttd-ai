class MachineBoiAi.Utils.Statement
{
    function coalesce(...)
    {
        for (local i = 0; i < vargc; i++) {
            if(vargv[i] != null){
                return vargv[i];
            }
        }
    }
}