class CompanyManager
{
    aiCompanyApi = null;

    constructor(_aiCompanyApi){
        this.aiCompanyApi = _aiCompanyApi;
    }

    function createCompany()
    {
        this.aiCompanyApi.SetName("YASSS");
        this.aiCompanyApi.SetPresidentName("HEEEEYO");
    }

    function importCompanyData(_version, _companyData)
    {
        this.createCompany();
        if("name" in _companyData){
             this.aiCompanyApi.SetName(_companyData.name);
        }

        if("presidentName" in _companyData){
             this.aiCompanyApi.SetPresidentName(_companyData.presidentName);
        }

        AILog.Info("Imported AI info");
    }

    function exportCompanyData()
    {
        AILog.Info("Exported AI info");
        return {
            name = this.aiCompanyApi.GetName(this.getId())
            presidentName = this.aiCompanyApi.GetPresidentName(this.getId())
        }
    }

    function getId()
    {
        return this.aiCompanyApi.COMPANY_SELF;
    }
}