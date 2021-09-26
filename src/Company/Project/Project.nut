using("MBAi.Data.Storable");
using("MBAi.Utils.Array");
using("MBAi.World.ModelFactory");

class MBAi.Company.Project.Project extends MBAi.Data.Storable
{
    constructor()
    {
        ::MBAi.Data.Storable.constructor();
        this.actionStates = {};
        this.targets = [];
        this.completed = false;
    }

    function addTarget(_target)
    {
        this.targets.push({
            type = _target.getModelName()
            id = _target.id
        });
    }

    function getTargets()
    {
        return ::MBAi.Utils.Array.map(this.targets, function(_target, _index, _targets){
            return ::MBAi.World.ModelFactory.createModel(_target.type, _target.id);
        });
    }

    function setActionState(_id, _state)
    {
        return this.actionStates[_id] <- _state;
    }

    function getActionState(_id, _default = null)
    {
        return (_id in this.actionStates) ? this.actionStates[_id] : _default;
    }

    function getStorageKey()
    {
        return "projects";
    }
}