/// @description find_holders([prop], [value]);
/// @function find_holders
/// @param [prop]
/// @param [value]
function find_holders() {
	var prop = "";
	var value = "";
    var type_str = "string";
    
    if(argument_count >= 2)
	{
	    prop = argument[0];
	    value = argument[1];
        
        if(is_string_number(value)) {
            value = parse_stringvalue("assetornumber", value);
            type_str = "assetornumber";
        } else {
            var obj = parse_stringvalue("object", value);
            if(obj != noone) {
                value = obj;
                type_str = "object";
            }
        }
	}
    
    if(prop != "") {
        my_console_write("filter: " + prop + "=" + string(value) + " (" + type_str + ")");
    }

	var count = 0;

	with(data_holder_obj)
	{
	    if(prop == "" || transform_memory[? prop] == value)
	    {
	        my_console_write(string(id) + "(" + object_get_name(transform_memory[? "object_index"]) + ")@[" + string(chunkgrid_x) + ", " + string(chunkgrid_y)+ "]; ["+string(x)+","+string(y)+"]");
	        count++;
	    }
	}

	return count;



}
