using("MBAi.World.Abstract.Model");
using("MBAi.World.Abstract.ModelRepository");

class MBAi.World.Cargo extends MBAi.World.Abstract.Model
{
    function getApi()
    {
        return ::AICargo;
    }

    function getModelName()
    {
        return "cargo";
    }

    function isValid()
    {
        return this.getApi().IsValidCargo(this.id);
    }

    function getName()
    {
        return this.isValid() ? this.getApi().GetName(this.id) : "";
    }

    function getLabel()
    {
        return this.isValid() ? this.getApi().GetCargoLabel(this.id) : "";
    }

    function isFreight()
    {
        return this.isValid() ? this.getApi().IsFreight(this.id) : false;
    }

    function hasCargoClass(_class)
    {
        return this.isValid() ? this.getApi().HasCargoClass(this.id, _class) : false;
    }

    function getTownEffect()
    {
        return this.isValid() ? this.getApi().GetTownEffect(this.id) : this.getApi().TE_NONE;
    }

    function evaluateCargoIncome(_distance, _daysInTransit)
    {
        return this.isValid() ? this.getApi().GetCargoIncome(this.id, _distance, _daysInTransit) : 0;
    }

    function getDistributionType()
    {
        return this.isValid() ? this.getApi().GetDistributionType(this.id) : this.getApi().INVALID_DISTRIBUTION_TYPE;
    }

    // STATIC
    function isValidTownEffect(_townEffect)
    {
        return ::MBAi.World.Cargo.getApi().IsValidTownEffect(_townEffect);
    }
}

class MBAi.World.Cargo.Repository extends MBAi.World.Abstract.ModelRepository
{
    function getModelClass()
    {
        return ::MBAi.World.Cargo;
    }

    function getListApi()
    {
        return ::AICargoList;
    }

    // AICargoList_IndustryAccepting	Creates a list of cargoes that the given industry accepts
    // AICargoList_IndustryProducing	Creates a list of cargoes that the given industry can produce
    // AICargoList_StationAccepting
}