function guy_orbit_insert(orb, guy) {
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

    var params = create_params_map(orb.id);
    params[? "who"] = guy.id;

    broadcast_event("orb_orbits", orb.id, params);
}
