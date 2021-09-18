local DataStore = using("MachineBoiAi.Data.DataStore");
local CompanyManager = using("MachineBoiAi.Company.CompanyManager");
local LogisticsDivision = using("MachineBoiAi.Company.Divisions.Logistics");
local ProjectRepository = using("MachineBoiAi.Company.Project.Repository");
local Project = using("MachineBoiAi.Company.Project.Project");

class MachineBoiAi.Controller extends AIController
{
    static DataStore = DataStore;
    static CompanyManager = CompanyManager;
    static LogisticsDivision = LogisticsDivision;
    static ProjectRepository = ProjectRepository;
    static Project = Project;

    companyManager = null;
    logisticsDivision = null;
    projectRepository = null;

    constructor()
    {
        this.companyManager = CompanyManager();
        this.logisticsDivision = LogisticsDivision();
        this.projectRepository = ProjectRepository();
    }

    function Start()
    {
        AILog.Info("MachineBoiAI Started.");
        this.companyManager.updateCompanyInfo();

        //set a legal railtype.
        local types = AIRailTypeList();
        AIRail.SetCurrentRailType(types.Begin());

        local project = Project();
        project.evaluation = 0;
        project.targets = [0, 0];
        project.destinationTiles = [AIMap.GetTileIndex(50, 50), AIMap.GetTileIndex(100, 112)];
        projectRepository.add(project);

        this.logisticsDivision.buildProject(project);

        //Keep running. If Start() exits, the AI dies.
        while (true) {
            this.Sleep(100);

            AILog.Warning("TODO: Add functionality to the AI EEEEE.");
        }
    }

    function Save()
    {
        AILog.Info("Saving AI data.");
        return DataStore.export();
    }

    function Load(version, data)
    {
        AILog.Info("Loading AI data.");
        DataStore.import(version, data);
    }
}