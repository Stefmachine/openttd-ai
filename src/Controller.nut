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
        MBAi.Logger.info("MBAi Started.");
        local company = Company();

        //set a legal railtype.
        local types = ::AIRailTypeList();
        ::AIRail.SetCurrentRailType(types.Begin());

        local project = Project();
        project.evaluation = 0;
        project.targets = [0, 0];
        project.destinationTiles = [::AIMap.GetTileIndex(50, 50), ::AIMap.GetTileIndex(100, 112)];
        company.projects.add(project);
        MBAi.Logger.info("Added project 1.");

        project = Project();
        project.evaluation = 2;
        project.targets = [0, 0];
        project.destinationTiles = [::AIMap.GetTileIndex(50, 50), ::AIMap.GetTileIndex(100, 112)];
        company.projects.add(project);
        MBAi.Logger.info("Added project 2.");

        foreach (i, project in company.projects) {
            MBAi.Logger.debug("index>{index} id>{project}", {index=i, project=project.id})
        }

        //this.logisticsDivision.buildProject(project);

        //Keep running. If Start() exits, the AI dies.
        while (true) {
        }
    }

    function Save()
    {
        MBAi.Logger.info("Saving MBAi data.");
        return DataStore.export();
    }

    function Load(version, data)
    {
        MBAi.Logger.info("Loading MBAi data from version {version}.", {version=version});
        DataStore.import(version, data);
    }
}