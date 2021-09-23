using("MBAi.Data.Store");
using("MBAi.Resource");
using("MBAi.Utils");
using("MBAi.Company.Project.Repository");
using("MBAi.Company.Personnel.Repository");
using("MBAi.Company.Divisions.Division")
using("MBAi.Company.Divisions.Accounting");
using("MBAi.Company.Divisions.Administration");
using("MBAi.Company.Divisions.HumanResources");
using("MBAi.Company.Divisions.Logistics");
using("MBAi.Company.Divisions.Marketing");


class MBAi.Company.Company {
    projects = null
    personnel = null
    administration = null
    logistics = null
    accounting = null
    hr = null
    marketing = null

    constructor()
    {
        this.projects = ::MBAi.Company.Project.Repository();
        this.personnel = ::MBAi.Company.Personnel.Repository();

        // Divisions
        this.administration = ::MBAi.Company.Divisions.Administration(this);
        this.logistics = ::MBAi.Company.Divisions.Logistics(this);
        this.accounting = ::MBAi.Company.Divisions.Accounting(this);
        this.hr = ::MBAi.Company.Divisions.HumanResources(this);
        this.marketing = ::MBAi.Company.Divisions.Marketing(this);
        this.setupCompany();
    }

    function getId()
    {
        return ::AICompany.COMPANY_SELF;
    }

    function getName()
    {
        return ::MBAi.Data.Store.data.company.name;
    }

    function setName(_name)
    {
        ::MBAi.Data.Store.data.company.name = _name;
        return ::AICompany.GetName(this.getId()) == _name || ::AICompany.SetName(_name);
    }

    function getPresident()
    {
        return this.personnel.findById(::MBAi.Data.Store.data.company.president);
    }

    function setPresident(_personnel)
    {
        if(_personnel.id != null){
            ::MBAi.Data.Store.transaction(function(_data):(_personnel){
                _personnel.division = ::MBAi.Company.Divisions.Division.DIVISION_ANY;
                _data.company.president = _personnel.id;
            });
            ::AICompany.SetPresidentGender(_personnel.gender);
            ::AICompany.SetPresidentName(_personnel.name);
        }
    }

    function getDivisions()
    {
        return [this.administration, this.logistics, this.accounting, this.hr, this.marketing];
    }

    function setupCompany()
    {
        // Setting company name
        local names = ::MBAi.Resource.loadResource("company.names");
        local iterations = 0;
        local name = this.getName();
        while ((name == null || !this.setName(name)) && iterations < 255) {
            iterations++;
            name = names[::AIBase.RandRange(names.len())];
        }

        if(this.getPresident() == null){
            local newPresident = this.hr.hirePersonnel();
            this.setPresident(newPresident);
        }

        foreach (division in this.getDivisions()) {
            if(division.getPersonnel().len() == 0){
                this.hr.hirePersonnel(division);
            }
        }

        ::MBAi.Logger.info("Company info, divisions and personnel({personnelCount}) setup.", {personnelCount=this.personnel.count()});
    }
}