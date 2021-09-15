using("MachineBoiAi.DataStore");
local CompanyManager = using("MachineBoiAi.Company.CompanyManager");

class MachineBoiAi.Controller extends AIController
{
    static CompanyManager = CompanyManager;
    companyManager = null;

    constructor()
    {
        this.companyManager = CompanyManager();
    }

    function Start()
    {
        AILog.Info("MachineBoiAI Started.");
        this.companyManager.updateCompanyInfo();

        //set a legal railtype.
        local types = AIRailTypeList();
        AIRail.SetCurrentRailType(types.Begin());

        //Keep running. If Start() exits, the AI dies.
        while (true) {
            this.Sleep(100);
            AILog.Warning("TODO: Add functionality to the AI EEEEE.");
        }
    }

    function Save()
    {
        AILog.Info("Saving AI data.");
        return MachineBoiAi.DataStore.export();
    }

    function Load(version, data)
    {
        AILog.Info("Loading AI data.");
        MachineBoiAi.DataStore.import(version, data);
    }
}