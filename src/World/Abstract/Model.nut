using("MBAi.Common.AbstractClass");

class MBAi.World.Abstract.Model extends MBAi.Common.AbstractClass
{
    id = null

    constructor(_id)
    {
        this.ensureSlotImplementation("getApi", "MBAi.World.Abstract.Model");
        this.ensureSlotImplementation("getModelName", "MBAi.World.Abstract.Model");
        this.ensureSlotImplementation("isValid", "MBAi.World.Abstract.Model");
        this.id = _id;
    }

    function isSame(_model)
    {
        return _model instanceof ::MBAi.World.Abstract.Model && this.id == _model.id && this.getModelName() == _model.getModelName();
    }
}