class MachineBoiAI extends AIInfo {
    function GetAuthor() {
        return "Stefmachine";
    }

    function GetName() {
        return "MachineBoiAI";
    }

    function GetDescription() {
        return "Just a shitty boi AI because I'm a newbie.";
    }

    function GetVersion() {
        return 1;
    }

    function GetDate() {
        return "2021-09-12";
    }

    function CreateInstance() {
        return "MachineBoiAI";
    }

    function GetShortName() {
        return "MBOI";
    }

    function GetAPIVersion() {
        return "1.9";
    }
}

RegisterAI(MachineBoiAI());