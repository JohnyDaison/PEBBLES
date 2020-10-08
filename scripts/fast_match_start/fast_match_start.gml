/// @description fast_match_start(control method, arena_index);
/// @function fast_match_start
/// @param control method
/// @param  arena_index
function fast_match_start() {

	/*
	var method = argument[0];
	var arena_index = 0;
	if(argument_count >= 2)
	    arena_index = argument[1];

	var match = instance_create(0,0,match_obj);


	// PLAYERS
	var player1 = instance_create(0,0,player_obj);
	player1.number = 1;
	player1.flag = "number1_flag";
	player1.icon = DB.bf_icon_map[? player1.flag];
	player1.name = "Johny Daison";

	if(method != gamepad) {
	    player1.control_set = 2*method + 1;
	}
	else {
	    player1.control_set = method;
	    player1.control_index = 0;
	}

	ds_map_add(match.players, 1, player1.id);


	var player2 = instance_create(0,0,player_obj);
	player2.number = 2;
	player2.flag = "number2_flag";
	player2.icon = DB.bf_icon_map[? player2.flag];
	player2.name = "CyberLabs";
	if(method != gamepad) {
	    player2.control_set = 2*method + 2;
	}
	else {
	    player2.control_set = method;
	    player2.control_index = 1;
	}

	ds_map_add(match.players, 2, player2.id);

	match.player_count = 2;

	// QUICK OPTIONS
	if(instance_exists(play_menu_window))
	{
	    var pane = play_menu_window.quick_pane;
    
	    player1.name = pane.name1_input.text;
	    player1.flag = DB.player_flags[| pane.flag1_input.value];
	    player1.icon = DB.bf_icon_map[? player1.flag];
	    player1.handicaps[? "min_damage"] = pane.handicap1_input.value;
	    player1.control_set = pane.p1control_dropdown.value;
	    player1.is_cpu = (pane.p1control_dropdown.value == cpu_control_set);
	    player1.cpu_difficulty = pane.p1cpudiff_input.value/10;
    
	    player2.name = pane.name2_input.text;
	    player2.flag = DB.player_flags[| pane.flag2_input.value];
	    player2.icon = DB.bf_icon_map[? player2.flag];
	    player2.handicaps[? "min_damage"] = pane.handicap2_input.value;
	    player2.control_set = pane.p2control_dropdown.value;
	    player2.is_cpu = (pane.p2control_dropdown.value == cpu_control_set);
	    player2.cpu_difficulty = pane.p2cpudiff_input.value/10;
    
	    match.sudden_death = pane.sudden_death.checked;
	    match.simple_mode = pane.simple_mode.checked;
	    match.hp_death = pane.hp_death.checked;
	    match.holographic_spawners = pane.holographic_spawners.checked;
	    match.weak_terrain = pane.weak_terrain.checked;
	}
    
	// LIMITS
	for(i=0; i<DB.limit_count; i+=1)
	{
	    limit_name = DB.limit_ids[| i];
	    switch(limit_name)
	    {
	        case "score":
	            match.limit_active[? limit_name] = true;
	            match.limits[? limit_name] = DB.limit_values[? i];
	            if(match.simple_mode)
	            {
	                match.limits[? limit_name] *= 0.5;
	            }
                                              
	            break;
	        /*
	        case "sudden_death":
	            match.limit_active[? limit_name] = true;
	            ds_map_replace(match.limits,limit_name,13);                                  
	            break;
	        *//*
	        default:
	            match.limit_active[? limit_name] = false;
	            break;
	    }
	}
   
	// match
 
	//match.starting_slots = 3;

	match.arena = ds_map_find_value(DB.arenas, arena_index);
	match.arena_name = ds_list_find_value(DB.arena_names, arena_index);

	match.world = instance_create(0,0, arena_world);
	match.world.current_place = match.world.places[| arena_index];
	match.arena_name = match.world.current_place.name;

	goto_arena();
	*/


}
