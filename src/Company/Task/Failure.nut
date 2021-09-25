using("MBAi.Logger");

class MBAi.Company.Task.Failure
{
    message = null;
    context = null;

    constructor(_message, _context = {})
    {
        this.message = _message;
        this.context = _context;
    }

    function report()
    {
        ::MBAi.Logger.debug(this.message, this.context);
    }
}