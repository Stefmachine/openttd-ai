using("MBAi.World.Abstract.Model");


class MBAi.World.Unknown extends MBAi.World.Abstract.Model
{
    function getApi()
    {
        return null;
    }

    function getModelName()
    {
        return "unknown";
    }

    function isValid()
    {
        return false;
    }

    function isSame(_model)
    {
        return false;
    }
}