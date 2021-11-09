using("MBAi.World.Abstract.Model");
using("MBAi.World.Subsidy");
using("MBAi.World.Town");
using("MBAi.World.Industry");
using("MBAi.World.Company");
using("MBAi.World.Cargo");
using("MBAi.World.Unknown");

class MBAi.World.ModelFactory
{
    static cache = {};
    static models = {
        [::MBAi.World.Subsidy.getModelName()] = ::MBAi.World.Subsidy,
        [::MBAi.World.Town.getModelName()] = ::MBAi.World.Town,
        [::MBAi.World.Industry.getModelName()] = ::MBAi.World.Industry,
        [::MBAi.World.Company.getModelName()] = ::MBAi.World.Company,
        [::MBAi.World.Cargo.getModelName()] = ::MBAi.World.Cargo
    };

    function createModel(_type, _id)
    {
        local model = ::MBAi.World.ModelFactory.getFromCache(_type, _id);
        if(model != null){
            return model;
        }

        if(_type in ::MBAi.World.ModelFactory.models){
            MBAi.Logger.debug("ModelFactory created type {type}", {type = _type});
            model = ::MBAi.World.ModelFactory.models[_type](_id);
        }
        else{
            MBAi.Logger.debug("ModelFactory created type unknown from {type}", {type = _type});
            model = ::MBAi.World.ModelFactory.createUnknown(_id);
        }

        ::MBAi.World.ModelFactory.saveToCache(_type, _id, model);
        return model;
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

    function getFromCache(_type, _id)
    {
        local key = _type+':'+_id;
        return (key in ::MBAi.World.ModelFactory.cache) ? ::MBAi.World.ModelFactory.cache[key] : null;
    }

    function saveToCache(_type, _id, _model)
    {
        ::MBAi.World.ModelFactory.cache[_type+':'+_id] <- _model;
        return true;
    }
}