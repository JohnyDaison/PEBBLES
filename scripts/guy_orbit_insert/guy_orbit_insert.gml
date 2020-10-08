/// @description guy_orbit_insert(orb_obj, guy_obj)
/// @function guy_orbit_insert
/// @param orb_obj
/// @param  guy_obj
function guy_orbit_insert(argument0, argument1) {
	var orb = argument0;
	var guy = argument1;

	orb.color_added = true;
	orb.orbit_anchor = guy.id;
	ds_list_add(guy.color_slots, orb.id);
	guy.last_slot_number = guy.slot_number;
	guy.slot_number = ds_list_size(guy.color_slots);
	guy.current_slot = guy.slot_number;

	if(guy.channeling)
	{
	    orb.read_terrain = true;
	    orb.alarm[6] = 1;
	}

	var params = ds_map_create();
	params[? "who"] = guy;
	register_ds("params", ds_type_map, params, orb);
            
	broadcast_event("orb_orbits", orb, params);



}
