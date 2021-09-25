using("MBAi.Resource");

class MBAi.Info extends AIInfo
{
    function GetAuthor() { return "Stefmachine"; }
    function GetName() { return "MachineBoiAi"; }
    function GetDescription() { return "Just a shitty boi AI because I'm a newbie."; }
    function GetVersion() { return 1; }
    function GetDate() { return "2021-09-12"; }
    function CreateInstance() { return "__MBAiController"; }
    function GetShortName() { return "MBAi"; }
    function GetAPIVersion() { return "1.10"; }

    function GetSettings()
    {
        local settingLabels = ::MBAi.Resource.loadResource("config.settings");
        this.AddSetting({
            name = "LogDebug",
            description = settingLabels.LogDebug.description,
            easy_value = 0,
            medium_value = 0,
            hard_value = 0,
            custom_value = 0,
            flags = ::AIInfo.CONFIG_BOOLEAN
        });
        this.AddSetting({
            name = "UsePrint",
            description = settingLabels.UsePrint.description,
            easy_value = 0,
            medium_value = 0,
            hard_value = 0,
            custom_value = 0,
            flags = ::AIInfo.CONFIG_BOOLEAN
        });
    }

}