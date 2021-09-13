class Autoloader
{
    instance = {};
    loaded = null;

    constructor(){
        this.loaded = {};
    }

    static function load(_class)
    {
        if(!("self" in Autoloader.instance)){
            Autoloader.instance.self <- Autoloader();
        }

        if(!(_class in Autoloader.instance.self.loaded)){
            require("src/"+_class+".nut");
            Autoloader.instance.self.loaded[_class] <- true;
        }

        return Autoloader.instance.self.loaded[_class];
    }
}

function using(_class)
{
    return Autoloader.load(_class);
}