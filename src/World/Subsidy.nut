using("MBAi.World.Abstract.Model");
using("MBAi.World.Abstract.ModelRepository");
using("MBAi.World.ModelFactory");
using("MBAi.World.Town");
using("MBAi.World.Company");

class MBAi.World.Subsidy extends MBAi.World.Abstract.Model
{
    function getApi()
    {
        return ::AISubsidy;
    }

    function getModelName()
    {
        return "subsidy";
    }

    function isValid()
    {
        return this.getApi().IsValidSubsidy(this.id);
    }

    function isExpired()
    {
        return !this.isValid();
    }

    function isAwarded()
    {
        return this.isValid() && this.getApi().IsAwarded(this.id);
    }

    function getAwardedCompany()
    {
        if(this.isAwarded()){
            return ::MBAi.World.Company(this.getApi().GetAwardedTo(this.id));
        }

        return null;
    }

    function getExpireDate()
    {
        if(!this.isValid()){
            return null;
        }

        return this.getApi().GetExpireDate(this.id);
    }

    function getSource()
    {
        if(!this.isValid()){
            return null;
        }

        return ::MBAi.World.ModelFactory.createFromSubsidyParticipantType(
            this.getApi().GetSourceType(this.id),
            this.getApi().GetSourceIndex(this.id)
        );
    }

    function getDestination()
    {
        if(!this.isValid()){
            return null;
        }

        return ::MBAi.World.ModelFactory.createFromSubsidyParticipantType(
            this.getApi().GetDestinationType(this.id),
            this.getApi().GetDestinationIndex(this.id)
        );
    }
}

class MBAi.World.Subsidy.Repository extends MBAi.World.Abstract.ModelRepository
{
    function getModelClass()
    {
        return ::MBAi.World.Subsidy;
    }

    function getListApi()
    {
        return ::AISubsidyList();
    }
}