using("MBAi.World.Abstract.Model");
using("MBAi.World.Abstract.ModelRepository");
using("MBAi.World.Company");
using("MBAi.Common.Collection");

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

    function getLastMonthReceived(_effect)
    {
        return this.isValid() && ::MBAi.World.Town.isValidEffect(_effect) ? this.getApi().GetLastMonthReceived(this.id, _effect) : 0;
    }

    function getCargoGoal(_effect)
    {
        return this.isValid() && ::MBAi.World.Town.isValidEffect(_effect) ? this.getApi().GetCargoGoal(this.id, _effect) : 0;
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

    // STATIC
    function foundTown(_tile, _size, _city, _layout, _name)
    {
        return ::MBAi.World.Town.FoundTown(_tile, _size, _city, _layout, _name);
    }

    function isValidEffect(_effect)
    {
        return ::MBAi.World.Cargo.getApi().IsValidTownEffect(_effect);
    }

    function getEffectList()
    {
        return ::AITownEffectList();
    }

    function getCargoProduced()
    {
        return ::MBAi.World.Cargo.Repository().findBy(function(_cargo, _index, _cargoes){
            return _cargo.hasCargoClass(MBAi.World.Cargo.getApi().CC_PASSENGERS)
                || _cargo.hasCargoClass(MBAi.World.Cargo.getApi().CC_MAIL);
        });
    }

    function getCargoAccepted()
    {
        return ::MBAi.World.Cargo.Repository().findBy(function(_cargo, _index, _cargoes){
            return _cargo.hasCargoClass(MBAi.World.Cargo.getApi().CC_PASSENGERS)
                || _cargo.hasCargoClass(MBAi.World.Cargo.getApi().CC_MAIL)
                || _cargo.hasCargoClass(MBAi.World.Cargo.getApi().CC_EXPRESS);
        });
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
        return ::AITownList();
    }
}