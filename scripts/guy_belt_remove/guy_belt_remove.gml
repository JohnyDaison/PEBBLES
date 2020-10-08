/// @description guy_belt_remove(orb_obj, guy_obj)
/// @function guy_belt_remove
/// @param orb_obj
/// @param  guy_obj
function guy_belt_remove(argument0, argument1) {
	var orb = argument0;
	var guy = argument1;

	orb.color_added = true;
	orb.invisible = false;

	var belt = guy.orb_belts[? orb.my_color];
	if(!is_undefined(belt) && ds_exists(belt, ds_type_list))
	{
	    var index = ds_list_find_index(belt, orb.id)
	    ds_list_delete(belt, index);
	}




}
