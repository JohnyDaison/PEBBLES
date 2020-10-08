/// @description guy_orbit_remove(orb_obj, guy_obj)
/// @function guy_orbit_remove
/// @param orb_obj
/// @param  guy_obj
function guy_orbit_remove(argument0, argument1) {
	var orb = argument0;
	var guy = argument1;

	// REMOVE ORB FROM COLOR SLOTS (GUY ORBIT)
	var index = ds_list_find_index(guy.color_slots, orb.id);
	ds_list_delete(guy.color_slots, index);
	guy.last_slot_number = guy.slot_number;
	guy.slot_number = ds_list_size(guy.color_slots);



}
