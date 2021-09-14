using("Company/CompanyManager");

class MachineBoiAi extends AIController {
    constructor() {}

    companyManager = CompanyManager();

    function Start() {
        AILog.Info("MachineBoiAI Started.");
        companyManager.createCompany();

        //set a legal railtype.
        local types = AIRailTypeList();
        AIRail.SetCurrentRailType(types.Begin());

        //Keep running. If Start() exits, the AI dies.
        while (true) {
            this.Sleep(100);
            AILog.Warning("TODO: Add functionality to the AI EEEEE.");
        }
    }

    function Save() {
        local table = {
            company = this.companyManager.exportCompanyData()
        };
        return table;
    }

    function Load(version, data) {
        AILog.Info(" Loaded");
        this.companyManager.importCompanyData(version, data);
    }
}