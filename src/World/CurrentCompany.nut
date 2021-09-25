using("MBAi.World.Company");

class MBAi.World.CurrentCompany extends MBAi.World.Company
{
    constructor()
    {
        ::MBAi.World.Company.constructor(this.getApi().COMPANY_SELF);
    }

    function setName(_name)
    {
        return this.getApi().SetName(_name);
    }

    function setPresidentName(_name)
    {
        return this.getApi().SetPresidentName(_name);
    }

    function setPresidentGender(_gender)
    {
        return this.getApi().SetPresidentGender(_gender);
    }

    function setLoanAmount(_loan)
    {
        return this.getApi().SetLoanAmount(_loan);
    }

    function setMinimumLoanAmount(_loan)
    {
        return this.getApi().SetMinimumLoanAmount(_loan);
    }

    function getLoanAmount()
    {
        return this.getApi().GetLoanAmount();
    }

    function getMaxLoanAmount()
    {
        return this.getApi().GetMaxLoanAmount();
    }

    function buildCompanyHQ(_tile)
    {
        return this.getApi().BuildCompanyHQ(_tile);
    }

    function setAutoRenewStatus(_autorenew)
    {
        return this.getApi().SetAutoRenewStatus(_autorenew);
    }

    function setAutoRenewMonths(_months)
    {
        return this.getApi().SetAutoRenewMonths(_months);
    }

    function setAutoRenewMoney(_money)
    {
        return this.getApi().SetAutoRenewMoney(_money);
    }

    function setPrimaryLiveryColour(_liveryScheme, _colour)
    {
        return this.getApi().SetPrimaryLiveryColour(_liveryScheme, _colour);
    }

    function setSecondaryLiveryColour(_liveryScheme, _colour)
    {
        return this.getApi().SetSecondaryLiveryColour(_liveryScheme, _colour);
    }

    function getPrimaryLiveryColour(_liveryScheme)
    {
        return this.getApi().GetPrimaryLiveryColour(_liveryScheme);
    }

    function getSecondaryLiveryColour(_liveryScheme)
    {
        return this.getApi().GetSecondaryLiveryColour(_liveryScheme);
    }
}