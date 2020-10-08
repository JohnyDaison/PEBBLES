/// @description find_holders(prop, [value]);
/// @function find_holders
/// @param prop
/// @param  value
function find_holders() {
	var prop = argument[0];
	var value = ""
	if(argument_count > 1)
	{
	    value = argument[1];
	}

	var count = 0;
	var value = parse_stringvalue("assetornumber", value);

	with(data_holder_obj)
	{
	    if(prop == "all" || transform_memory[? prop] == value)
	    {
	        my_console_write(string(id) + "(" + object_get_name(transform_memory[? "object_index"]) + ")@[" + string(chunkgrid_x) + ", " + string(chunkgrid_y)+ "]; ["+string(x)+","+string(y)+"]");
	        count++;
	    }
	}

	return count;



}
