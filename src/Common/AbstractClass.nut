class MBAi.Common.AbstractClass
{
    function ensureSlotImplementation(_slot, _baseClassName)
    {
        if(!(_slot in this)){
            throw "'"+_slot+"' must be implemented in child class of "+_baseClassName+" class.";
        }
    }
}