using("MBAi.Data.DataStore");
using("MBAi.Company.Company");
using("MBAi.Company.Project.Project");
using("MBAi.Logger");

class MBAi.Controller extends AIController
{
    static DataStore = MBAi.Data.DataStore;
    static Company = MBAi.Company.Company;
    static Project = MBAi.Company.Project.Project;

    function Start()
    {
        MBAi.Logger.warn("MBAi Started.");
        local company = Company();

        //set a legal railtype.
        local types = AIRailTypeList();
        AIRail.SetCurrentRailType(types.Begin());

        local project = Project();
        project.evaluation = 0;
        project.targets = [0, 0];
        project.destinationTiles = [AIMap.GetTileIndex(50, 50), AIMap.GetTileIndex(100, 112)];
        company.projects.add(project);

        //this.logisticsDivision.buildProject(project);

        //Keep running. If Start() exits, the AI dies.
        while (true) {
        }
    }

    function Save()
    {
        MBAi.Logger.info("Saving MBAI data.");
        return DataStore.export();
    }

    function Load(version, data)
    {
        MBAi.Logger.info("Loading MBAI data from version {version}.", {version=version});
        DataStore.import(version, data);
    }
}