class ArrayHelper
{
    function join(_array, _separator = "")
    {
        local string = "";
        foreach (index,value in _array) {
            string += value.tostring();
            if(index != _array.len() - 1){
                string += _separator;
            }
        }

        return string;
    }
}