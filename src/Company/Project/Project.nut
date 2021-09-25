using("MBAi.Data.Storable");
using("MBAi.Utils.Array");
using("MBAi.World.ModelFactory");

class MBAi.Company.Project.Project extends MBAi.Data.Storable
{
    constructor()
    {
        ::MBAi.Data.Storable.constructor();
        this.evaluation = null;
        this.targets = [];
        this.destinationTiles = [];
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

    function getStorageKey()
    {
        return "projects";
    }
}