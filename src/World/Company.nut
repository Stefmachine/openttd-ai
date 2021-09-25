using("MBAi.World.Abstract.Model");
using("MBAi.World.Abstract.ModelRepository");

class MBAi.World.Company extends MBAi.World.Abstract.Model
{
    function getApi()
    {
        return ::AICompany;
    }

    function getModelName()
    {
        return "company";
    }

    function isValid()
    {
        return this.getApi().ResolveCompanyID(this.id) != this.getApi().COMPANY_INVALID;
    }

    function getName()
    {
        return this.isValid() ? this.getApi().GetName(this.id) : "";
    }

    function getPresidentName()
    {
        return this.isValid() ? this.getApi().GetPresidentName(this.id) : "";
    }

    function getPresidentName()
    {
        return this.isValid() ? this.getApi().GetPresidentGender(this.id) : "";
    }

    function getLoanInterval()
    {
        return this.getApi().GetLoanInterval();
    }

    function getBankBalance()
    {
        return this.isValid() ? this.getApi().GetBankBalance(this.id) : 0;
    }

    function getQuarterlyIncome(_quarter)
    {
        return this.isValid() ? this.getApi().GetQuarterlyIncome(this.id, _quarter) : 0;
    }

    function getQuarterlyExpenses(_quarter)
    {
        return this.isValid() ? this.getApi().GetQuarterlyExpenses(this.id, _quarter) : 0;
    }

    function getQuarterlyCargoDelivered(_quarter)
    {
        return this.isValid() ? this.getApi().GetQuarterlyCargoDelivered(this.id, _quarter) : 0;
    }

    function getQuarterlyPerformanceRating(_quarter)
    {
        return this.isValid() ? this.getApi().GetQuarterlyPerformanceRating(this.id, _quarter) : 0;
    }

    function getQuarterlyCompanyValue(_quarter)
    {
        return this.isValid() ? this.getApi().GetQuarterlyCompanyValue(this.id, _quarter) : 0;
    }

    function getCompanyHQ()
    {
        return this.isValid() ? this.getApi().GetCompanyHQ(this.id) : ::AIMap.TILE_INVALID;
    }

    function getAutoRenewStatus()
    {
        return this.isValid() ? this.getApi().GetAutoRenewStatus(this.id) : false;
    }

    function getAutoRenewMonths()
    {
        return this.isValid() ? this.getApi().GetAutoRenewMonths(this.id) : 0;
    }

    function getAutoRenewMoney()
    {
        return this.isValid() ? this.getApi().GetAutoRenewMoney(this.id) : 0;
    }
}

class MBAi.World.Company.Repository extends MBAi.World.Abstract.ModelRepository
{
    function getModelClass()
    {
        return ::MBAi.World.Company;
    }

    function getListApi()
    {
        return ::AICompanyList();
    }
}