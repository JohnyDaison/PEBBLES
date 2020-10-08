/// @description stat_label(stat, [value, type])
/// @function stat_label
/// @param stat
/// @param  [value
/// @param  type]
function stat_label() {
	var stat = argument[0];
	var value = undefined;
	var type = ""; /* ""|"+"|"-" */

	if(argument_count > 1)
	{
	    value = argument[1];
	}

	if(argument_count > 2)
	{
	    type = argument[2];
	}

	var stat_name = "", value_prefix = "", stat_str = "";

	var DBindex = ds_list_find_index(DB.stats_display_keys, stat);

	if(DBindex != -1)
	{
	    stat_name = DB.stats_display_labels[| DBindex];
    
	    if(!is_undefined(value))
	    {
	        if((type == "+" || type == "-"))
	        {
	            if(type == "-")
	            {
	                value *= -1;
	            }
            
	            if(value >= 0)
	            {
	                value_prefix = "+";
	            }
	        }
        
	        stat_str = stat_name + " " + value_prefix + string(value);
	    }
	}

	return stat_str;



}
