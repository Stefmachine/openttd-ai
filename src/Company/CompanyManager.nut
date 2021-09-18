local DataStore = using("MachineBoiAi.Data.DataStore");
local ResourceManager = using("MachineBoiAi.Resource");
local Utils = using("MachineBoiAi.Utils");

class MachineBoiAi.Company.CompanyManager {
    static ResourceManager = ResourceManager;
    static Utils = Utils;
    static DataStore = DataStore

    function updateCompanyInfo() {
        // Setting company name
        local names = ResourceManager.loadResource("company.names");
        local iterations = 0;
        local name = DataStore.data.company.name;
        while ((name == null || !AICompany.SetName(name)) && iterations < 255) {
            iterations++;
            name = names[AIBase.RandRange(names.len())];
        }
        DataStore.data.company.name = AICompany.GetName(this.getId());

        // Setting president gender
        DataStore.data.company.president.gender = Utils.Statement.coalesce(DataStore.data.company.president.gender, [AICompany.GENDER_MALE, AICompany.GENDER_FEMALE][AIBase.RandRange(2)]);
        AICompany.SetPresidentGender(DataStore.data.company.president.gender);

        // Setting president name
        local presidentNames = ResourceManager.loadResource("company.president_names");
        local randomPresidentName = presidentNames[DataStore.data.company.president.gender][AIBase.RandRange(presidentNames[DataStore.data.company.president.gender].len())]
        DataStore.data.company.president.name = Utils.Statement.coalesce(DataStore.data.company.president.name, randomPresidentName);
        AICompany.SetPresidentName(DataStore.data.company.president.name);
        AILog.Info("Updated company info.");
    }

    function getId() {
        return AICompany.COMPANY_SELF;
    }
}