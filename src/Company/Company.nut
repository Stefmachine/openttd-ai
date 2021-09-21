using("MBAi.Data.DataStore");
using("MBAi.Resource");
using("MBAi.Utils");
using("MBAi.Company.Project.Repository");
using("MBAi.Company.Divisions.Accounting");
using("MBAi.Company.Divisions.Logistics");

class MBAi.Company.Company {
    static ResourceManager = MBAi.Resource;
    static Utils = MBAi.Utils;
    static DataStore = MBAi.Data.DataStore;

    projects = null
    accounting = null
    logistics = null

    constructor()
    {
        this.updateCompanyInfo();
        this.projects = MBAi.Company.Project.Repository();
        local Divisions = MBAi.Company.Divisions;
        this.accounting = Divisions.Accounting();
        this.logistics = Divisions.Logistics();
    }

    function getId()
    {
        return AICompany.COMPANY_SELF;
    }

    function getName()
    {
        return DataStore.data.company.name;
    }

    function setName(_name)
    {
        DataStore.data.company.name = _name;
    }

    function getPresident()
    {
        return DataStore.data.company.president;
    }

    function updateCompanyInfo()
    {
        // Setting company name
        local names = ResourceManager.loadResource("company.names");
        local iterations = 0;
        local name = this.getName();
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
        MBAi.Logger.info("Updated company info.");
    }
}