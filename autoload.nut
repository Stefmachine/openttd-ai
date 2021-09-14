class Autoloader
{
    static loaded = {};

    function load(_class)
    {
        if(!(_class in Autoloader.loaded)){
            Autoloader.loaded[_class] <- true;
            require("src/"+_class+".nut");
        }

        return Autoloader.loaded[_class];
    }
}

function using(_class)
{
    return Autoloader.load(_class);
}