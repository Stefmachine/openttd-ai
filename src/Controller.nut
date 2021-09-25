using("MBAi.Data.Store");
using("MBAi.Company.CompanyManager");
using("MBAi.Logger");

class MBAi.Controller extends AIController
{
    function Start()
    {
        ::MBAi.Logger.info("MBAi Started.");
        local company = ::MBAi.Company.CompanyManager();
        ::MBAi.Data.Store.transaction(function():(company){
            company.setup();
        });

        local updateInTransaction = function():(company){
            company.carryOutRoutine(::AIDate.GetCurrentDate());
        };

        while (true) {
            ::MBAi.Data.Store.transaction(updateInTransaction);
        }
    }

    function Save()
    {
        ::MBAi.Logger.info("Saving MBAi data.");
        return ::MBAi.Data.Store.export();
    }

    function Load(version, data)
    {
        ::MBAi.Logger.info("Loading MBAi data from version {version}.", {version=version});
        ::MBAi.Data.Store.import(version, data);
    }
}