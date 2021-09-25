using("MBAi.World.Abstract.Model");
using("MBAi.World.Abstract.ModelRepository");
using("MBAi.World.Company");

class MBAi.World.Industry extends MBAi.World.Abstract.Model
{
    function getApi()
    {
        return ::AIIndustry;
    }

    function getModelName()
    {
        return "industry";
    }

    function isValid()
    {
        return this.getApi().IsValidIndustry(this.id);
    }

    function getName()
    {
        return this.isValid() ? this.getApi().GetName() : "";
    }

    function isCargoAccepted(_cargo)
    {
        return this.isValid() && _cargo.isValid() ? this.getApi().IsCargoAccepted(_cargo.id) == this.getApi().CAS_ACCEPTED : false;
    }

    function isTemporarlyRefused(_cargo)
    {
        return this.isValid() && _cargo.isValid() ? this.getApi().IsCargoAccepted(_cargo.id) == this.getApi().CAS_TEMP_REFUSED : false;
    }

    function getStockpiledCargo(_cargo)
    {
        return this.isValid() && _cargo.isValid() ? this.getApi().GetStockpiledCargo(_cargo.id) : 0;
    }

    function getLastMonthProduction(_cargo)
    {
        return this.isValid() && _cargo.isValid() ? this.getApi().GetLastMonthProduction(_cargo.id) : 0;
    }

    function getLastMonthTransported(_cargo)
    {
        return this.isValid() && _cargo.isValid() ? this.getApi().GetLastMonthTransported(_cargo.id) : 0;
    }

    function getLastMonthTransportedPercentage(_cargo)
    {
        return this.isValid() && _cargo.isValid() ? this.getApi().GetLastMonthTransportedPercentage(_cargo.id) : 0;
    }

    function getLocation()
    {
        return this.isValid() ? this.getApi().GetLocation(this.id) : ::AIMap.TILE_INVALID;
    }

    function getAmountOfStationsAround()
    {
        return this.isValid() ? this.getApi().GetAmountOfStationsAround(this.id) : 0;
    }

    function getDistanceManhattanToTile(_tile)
    {
        return this.isValid() ? this.getApi().GetDistanceManhattanToTile(this.id, _tile) : null;
    }

    function getDistanceSquareToTile(_tile)
    {
        return this.isValid() ? this.getApi().GetDistanceSquareToTile(this.id, _tile) : null;
    }

    function isBuildOnWater()
    {
        return this.isValid() ? this.getApi().IsBuildOnWater() : false;
    }

    function hasHeliport()
    {
        return this.isValid() ? this.getApi().HasHeliport() : false;
    }

    function getHeliportLocation()
    {
        return this.hasHeliport() ? this.getApi().GetHeliportLocation(this.id) : ::AIMap.TILE_INVALID;
    }

    function hasDock()
    {
        return this.isValid() ? this.getApi().HasDock() : false;
    }

    function getDockLocation()
    {
        return this.hasDock() ? this.getApi().GetDockLocation(this.id) : ::AIMap.TILE_INVALID;
    }

    function getIndustryType()
    {
        return this.isValid() ? this.getApi().GetIndustryType(this.id) : null;
    }

    function getExclusiveSupplier()
    {
        if(this.isValid()){
            local companyId = this.getApi().GetExclusiveSupplier(this.id);
            local company = ::MBAi.World.Company(companyId);
            if(company.isValid()){
                return company;
            }
        }

        return null;
    }

    function getExclusiveConsumer()
    {
        if(this.isValid()){
            local companyId = this.getApi().GetExclusiveConsumer(this.id);
            local company = ::MBAi.World.Company(companyId);
            if(company.isValid()){
                return company;
            }
        }

        return null;
    }
}

class MBAi.World.Industry.Repository extends MBAi.World.Abstract.ModelRepository
{
    function getModelClass()
    {
        return ::MBAi.World.Industry;
    }

    function getListApi()
    {
        return ::AIIndustryList;
    }

    // AIIndustryList_CargoAccepting > Creates a list of industries that accepts a given cargo
    // AIIndustryList_CargoProducing > Creates a list of industries that can produce a given cargo
}