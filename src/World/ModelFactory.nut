using("MBAi.World.Abstract.Model");
using("MBAi.World.Subsidy");
using("MBAi.World.Town");
using("MBAi.World.Industry");
using("MBAi.World.Company");
using("MBAi.World.Cargo");
using("MBAi.World.Unknown");

class MBAi.World.ModelFactory
{
    static models = {
        [::MBAi.World.Subsidy.getModelName()] = ::MBAi.World.Subsidy,
        [::MBAi.World.Town.getModelName()] = ::MBAi.World.Town,
        [::MBAi.World.Industry.getModelName()] = ::MBAi.World.Industry,
        [::MBAi.World.Company.getModelName()] = ::MBAi.World.Company,
        [::MBAi.World.Cargo.getModelName()] = ::MBAi.World.Cargo
    };

    function createModel(_type, _id)
    {
        if(_type in ::MBAi.World.ModelFactory.models){
            MBAi.Logger.debug("Created type {type}", {type = _type});
            return ::MBAi.World.ModelFactory.models[_type](_id);
        }

        MBAi.Logger.debug("Created type unknown from {type}", {type = _type});
        return ::MBAi.World.ModelFactory.createUnknown(_id);
    }

    function createUnknown(_id)
    {
        return ::MBAi.World.Unknown(_id);
    }

    function createFromSubsidyParticipantType(_type, _id)
    {
        local modelTypeMap = {
            [::MBAi.World.Subsidy.getApi().SPT_TOWN] = ::MBAi.World.Town.getModelName(),
            [::MBAi.World.Subsidy.getApi().SPT_INDUSTRY] = ::MBAi.World.Industry.getModelName()
        };

        if(_type in modelTypeMap){
            return ::MBAi.World.ModelFactory.createModel(modelTypeMap[_type], _id);
        }

        return ::MBAi.World.ModelFactory.createUnknown(_id);
    }
}