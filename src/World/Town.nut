using("MBAi.World.Abstract.Model");
using("MBAi.World.Abstract.ModelRepository");
using("MBAi.World.Company");

class MBAi.World.Town extends MBAi.World.Abstract.Model
{
    function getApi()
    {
        return ::AITown;
    }

    function getModelName()
    {
        return "town";
    }

    function isValid()
    {
        return this.getApi().IsValidTown(this.id);
    }

    function getName()
    {
        return this.isValid() ? this.getApi().GetName(this.id) : "";
    }

    function getPopulation()
    {
        return this.isValid() ? this.getApi().GetPopulation(this.id) : 0;
    }

    function getHouseCount()
    {
        return this.isValid() ? this.getApi().GetHouseCount(this.id) : 0;
    }

    function getLocation()
    {
        return this.isValid() ? this.getApi().GetLocation(this.id) : ::AIMap.TILE_INVALID;
    }

    function getLastMonthProduction(_cargo)
    {
        return this.isValid() && _cargo.isValid() ? this.getApi().GetLastMonthProduction(this.id, _cargo.id) : 0;
    }

    function getLastMonthSupplied(_cargo)
    {
        return this.isValid() && _cargo.isValid() ? this.getApi().GetLastMonthSupplied(this.id, _cargo.id) : 0;
    }

    function getLastMonthTransportedPercentage(_cargo)
    {
        return this.isValid() && _cargo.isValid() ? this.getApi().GetLastMonthTransportedPercentage(this.id, _cargo.id) : 0;
    }

    function getLastMonthReceived(_cargoTownEffect)
    {
        return this.isValid() && ::MBAi.World.Cargo.isValidTownEffect(_cargoTownEffect)
            ? this.getApi().GetLastMonthReceived(this.id, _cargoTownEffect) : 0;
    }

    function getCargoGoal(_cargoTownEffect)
    {
        return this.isValid() && ::MBAi.World.Cargo.isValidTownEffect(_cargoTownEffect)
            ? this.getApi().GetCargoGoal(this.id, _cargoTownEffect) : 0;
    }

    function getGrowthRate()
    {
        return this.isValid() ? this.getApi().GetGrowthRate(this.id) : 0;
    }

    function getDistanceManhattanToTile(_tile)
    {
        return this.isValid() ? this.getApi().GetDistanceManhattanToTile(this.id, _tile) : null;
    }

    function getDistanceSquareToTile(_tile)
    {
        return this.isValid() ? this.getApi().GetDistanceSquareToTile(this.id, _tile) : null;
    }

    function isWithinTownInfluence(_tile)
    {
        return this.isValid() ? this.getApi().IsWithinTownInfluence(this.id, _tile) : false;
    }

    function hasStatue()
    {
        return this.isValid() ? this.getApi().HasStatue(this.id) : false;
    }

    function isCity()
    {
        return this.isValid() ? this.getApi().IsCity(this.id) : false;
    }

    function getRoadReworkDuration()
    {
        return this.isValid() ? this.getApi().GetRoadReworkDuration(this.id) : 0;
    }

    function getFundBuildingsDuration()
    {
        return this.isValid() ? this.getApi().GetFundBuildingsDuration(this.id) : 0;
    }

    function GetExclusiveRightsCompany()
    {
        if(this.isValid()){
            local companyId = this.getApi().GetExclusiveRightsCompany(this.id);
            local company = ::MBAi.World.Company(companyId);
            if(company.isValid()){
                return ;
            }
        }
        return null;
    }

    function getExclusiveRightsDuration()
    {
        return this.isValid() ? this.getApi().GetExclusiveRightsDuration(this.id) : 0;
    }

    function isActionAvailable(_townAction)
    {
        return this.isValid() ? this.getApi().isActionAvailable(this.id, _townAction) : false;
    }

    function performAction(_townAction)
    {
        return this.isActionAvailable(_townAction) ? this.getApi().PerformTownAction(this.id, _townAction) : false;
    }

    function getRating(_company)
    {
        return _company.isValid() && this.isValid() ? this.getApi().GetRating(_company.id) : this.getApi().TOWN_RATING_NONE;
    }

    function getAllowedNoise()
    {
        return this.isValid() ? this.getApi().GetAllowedNoise(this.id) : 0;
    }

    function getRoadLayout()
    {
        return this.isValid() ? this.getApi().GetRoadLayout(this.id) : this.getApi().ROAD_LAYOUT_ORIGINAL;
    }
}

class MBAi.World.Town.Repository extends MBAi.World.Abstract.ModelRepository
{
    function getModelClass()
    {
        return ::MBAi.World.Town;
    }

    function getListApi()
    {
        return ::AITownList;
    }
}