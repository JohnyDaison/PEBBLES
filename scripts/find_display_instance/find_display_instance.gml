/// @description find_display_instance(display_type, display_index, display_id)
/// @function find_display_instance
/// @param display_type
/// @param  display_index
/// @param  display_id
function find_display_instance(argument0, argument1, argument2) {
	var display_type = argument0;
	var display_index = argument1;
	var display_id = argument2;

	var disp_obj = noone;

	if(display_type == "index")
	{
	    disp_obj = self.order[? display_index];
	}
	else if(display_type == "id")
	{
	    disp_obj = self.member_ids[? display_id];
	}

	return disp_obj;



}
