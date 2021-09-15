local DataStore = using("MachineBoiAi.DataStore");
local ResourceManager = using("MachineBoiAi.Resources.ResourceManager");

class MachineBoiAi.Company.CompanyManager {
    static ResourceManager = ResourceManager;
    static company = DataStore.data.company;

    function updateCompanyInfo() {
        // Setting company name
        local names = ResourceManager.loadResource("company.names");
        local iterations = 0;
        local name = company.name;
        while ((name == null || !AICompany.SetName(name)) && iterations < 255) {
            iterations++;
            name = names[AIBase.RandRange(names.len())];
        }
        company.name = AICompany.GetName(this.getId());

        // Setting president gender
        company.president.gender = company.president.gender != null ? company.president.gender : [AICompany.GENDER_MALE, AICompany.GENDER_FEMALE][AIBase.RandRange(2)];
        AICompany.SetPresidentGender(company.president.gender);

        // Setting president name
        local presidentNames = ResourceManager.loadResource("company.president_names");
        local randomPresidentName = presidentNames[company.president.gender][AIBase.RandRange(presidentNames[company.president.gender].len())]
        company.president.name = company.president.name != null ? company.president.name : randomPresidentName
        AICompany.SetPresidentName(company.president.name);
    }

    function getId() {
        return AICompany.COMPANY_SELF;
    }
}