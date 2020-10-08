/// @function has_left_step
function has_left_step() {
	var i, key, inst;
	var count = ds_list_size(has_not_left_list);

	for(i = count - 1; i >= 0; i--)
	{
	    key = has_not_left_list[| i];
    
	    if(!instance_exists(key) || !place_meeting(x,y, key))
	    {
	        has_left_inst[? key] = true;
	        ds_list_delete(has_not_left_list, i);
	    }    
	}





}
