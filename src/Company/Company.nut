using("MBAi.Data.Store");
using("MBAi.Resource");
using("MBAi.Utils");
using("MBAi.Utils.Date");
using("MBAi.Utils.Event");
using("MBAi.Company.Project.Repository");
using("MBAi.Company.Personnel.Repository");
using("MBAi.Company.Task.Repository");
using("MBAi.Company.Division.Division")
using("MBAi.Company.Division.Accounting");
using("MBAi.Company.Division.Administration");
using("MBAi.Company.Division.HumanResources");
using("MBAi.Company.Division.Logistics");
using("MBAi.Company.Division.Marketing");
using("MBAi.Logger");

class MBAi.Company.Company {
    projects = null;
    personnel = null;
    tasks = null;

    administration = null;
    logistics = null;
    accounting = null;
    hr = null;
    marketing = null;

    constructor()
    {
        this.projects = ::MBAi.Company.Project.Repository();
        this.personnel = ::MBAi.Company.Personnel.Repository();
        this.tasks = ::MBAi.Company.Task.Repository();

        // Divisions
        this.administration = ::MBAi.Company.Division.Administration(this);
        this.logistics = ::MBAi.Company.Division.Logistics(this);
        this.accounting = ::MBAi.Company.Division.Accounting(this);
        this.hr = ::MBAi.Company.Division.HumanResources(this);
        this.marketing = ::MBAi.Company.Division.Marketing(this);
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
            _personnel.division = ::MBAi.Company.Division.Division.DIVISION_ANY;
            ::MBAi.Data.Store.data.company.president = _personnel.id;
            ::AICompany.SetPresidentGender(_personnel.gender);
            ::AICompany.SetPresidentName(_personnel.name);
        }
    }

    function getDivisions()
    {
        return [this.administration, this.logistics, this.accounting, this.hr, this.marketing];
    }

    function setup()
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

    lastDate = null;
    function carryOutRoutine(_date)
    {
        while(::AIEventController.IsEventWaiting()){
            local event = ::MBAi.Utils.Event.convert(::AIEventController.GetNextEvent());
            ::MBAi.Logger.debug("Event type {type} fired.", {type=event.GetEventType()});
            foreach (division in this.getDivisions()) {
                division.createTasksFromEvent(event);
            }
        }

        if(this.lastDate != null && _date <= this.lastDate){
            return; // Daily ticks
        }

        local startOfYear = ::MBAi.Utils.Date.startOfYear(_date);
        local startOfMonth = ::MBAi.Utils.Date.startOfMonth(_date);
        if(this.lastDate != null && this.lastDate < startOfYear && _date >= startOfYear){
            this.carryOutYearlyRoutine(startOfYear);
        }

        if(this.lastDate != null && this.lastDate < startOfMonth && _date >= startOfMonth){
            this.carryOutMonthlyRoutine(startOfMonth);
        }

        this.carryOutDailyRoutine(_date);

        this.lastDate = _date;
    }

    function carryOutDailyRoutine(_date)
    {
        ::MBAi.Logger.debug("Carrying out daily routine on {date}.", {date=::MBAi.Utils.Date.format(_date)});

        foreach (division in this.getDivisions()) {
            division.createTasks();
        }

        foreach (division in this.getDivisions()) {
            division.assignTasks();
        }

        local jokerPersonnel = this.personnel.findBy(function(_person, _index, _personnel){
            return _person.division == ::MBAi.Company.Division.Division.DIVISION_ANY
                && ::MBAi.Utils.Array.indexOf(
                    ::MBAi.Data.Store.data[::MBAi.Company.Task.Task.getStorageKey()].assignedPersonnel,
                    _person.id
            ) == -1;
        });

        while (jokerPersonnel.len() > 0) {
            foreach (division in this.getDivisions()) {
                if(jokerPersonnel.len() > 0){
                    division.assignPersonnelToAnyTask(jokerPersonnel[0]);
                    jokerPersonnel.remove(0);
                }
            }
        }

        foreach (division in this.getDivisions()) {
            division.carryOutTasks();
        }
    }

    function carryOutMonthlyRoutine(_date)
    {
        ::MBAi.Logger.debug("Carrying out monthly routine on {date}.", {date=::MBAi.Utils.Date.format(_date)});
    }

    function carryOutYearlyRoutine(_date)
    {
        ::MBAi.Logger.debug("Carrying out yearly routine on {date}.", {date=::MBAi.Utils.Date.format(_date)});
    }
}