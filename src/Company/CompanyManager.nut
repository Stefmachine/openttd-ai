using("Resources/ResourceManager");

class CompanyManager
{
    function createCompany()
    {
        local names = ResourceManager.loadResource("company.names");
        local presidentNames = ResourceManager.loadResource("company.president_names");
        local gender = [AICompany.GENDER_MALE, AICompany.GENDER_FEMALE][AIBase.RandRange(2)];
        AICompany.SetPresidentGender(gender);
        AICompany.SetName(names[AIBase.RandRange(names.len())]);
        AICompany.SetPresidentName(presidentNames[gender][AIBase.RandRange(presidentNames[gender].len())]);

        AILog.Info("Created company with data: "+this.exportCompanyData().tostring());
    }

    function importCompanyData(_version, _companyData)
    {
        this.createCompany();
        if("name" in _companyData){
             AICompany.SetName(_companyData.name);
        }

        if("presidentName" in _companyData){
             AICompany.SetPresidentName(_companyData.presidentName);
        }

        AILog.Info("Imported AI info");
    }

    function exportCompanyData()
    {
        AILog.Info("Exported AI info");
        return {
            name = AICompany.GetName(this.getId())
            gender = AICompany.GetPresidentGender(this.getId())
            presidentName = AICompany.GetPresidentName(this.getId())
        }
    }

    function getId()
    {
        return AICompany.COMPANY_SELF;
    }
}