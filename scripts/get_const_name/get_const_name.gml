/// @description Get a string name for a physical input
/// @param {integer} input_method    the input device
/// @param {integer} code    the input id
function get_const_name(input_method, code) {
    var val = undefined;

    if(input_method == keyboard)
    {
        if(code >= ord("A") && code <= ord("Z"))
        {
            val = chr(code);   
        }
        else
        {
            val = DB.keynames[? code];
        }
    }
    if(input_method == gamepad)
    {
        val = DB.padnames[? code];
    }

    if(val != undefined)
    {
        return string(val);
    }
    else
    {
        return "["+string(code)+"]";
    }
}
