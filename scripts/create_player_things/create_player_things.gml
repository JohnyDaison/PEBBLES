/// @param player
function create_player_things() {
	var player = argument[0];
	var new_guy = noone;

	// CREATE SPAWN POINT
	guy_spawn_point_create(id, player, true);
	/*
	if(is_undefined(self.spawn_points[? player.number]))
	{
	    ii = instance_create(x,y, guy_spawn_point_obj);
	    ii.my_spawner = id;
	    ii.my_player = player;
	    ii.activated = true;

	    self.spawn_points[? player.number] = ii;
	}
	*/


	var has_view = (gamemode_obj.human_player_count < 2 && player.number <= 2) || !player.is_cpu;
	var player_camera = noone;

	if(has_view)
	{
	    // CREATE CAMERA
	    var ii = instance_create(x,y,player_camera_obj);

	    ii.on = true;
	    player_camera = ii;
	    player_camera.view = player.number;
	    player_camera.depth -= player_camera.view; // is this needed?

	    if(gamemode_obj.player_count == 1)
	    {
	        player_camera.only_cam = true;
	    }

	    player_camera.my_spawner = self.id;
	    player_camera.follow_spawner = true;
	    player_camera.player = player.number;
	    player_camera.my_player = player;
	    player_camera.zoom_level = player_camera.min_zoom;

	    player.my_camera = player_camera;
	}

	player.my_spawner = id;
	player.my_base = id;

	// GUY
	if(player.is_cpu)
	{
	    new_guy = instance_create(x,y, basic_bot);
    
	    with(new_guy)
	    {
	        my_player = player;
	        if(gamemode_obj.mode == "volleyball")
	        {
	            /*
	            if(player.number == 1)
	            {
	                volleyball_bot1_init();
	                npc_script = volleyball_bot1;
	                npc_destroy_script = volleyball_bot1_destroy;
	            }
	            else
	            {*/
	                volleyball_bot2_init();
	                npc_script = volleyball_bot2;
	                npc_destroy_script = volleyball_bot2_destroy;
	            //}
	        }
	        else if(instance_exists(place_controller_obj) && place_controller_obj.nav_graph_exists)
	        {
	            arena_bot3_init();
	            npc_script = arena_bot3;
	            npc_destroy_script = arena_bot3_destroy;
	        }
	        else
	        {
	            arena_bot1_init();
	            npc_script = arena_bot1;
	        }
	        difficulty = player.cpu_difficulty;
	        bot_speed = difficulty;
	        bot_complexity = difficulty;
	        bot_aggressiveness = difficulty;
        
	        if(object_index == guy_spawner_obj) // it's about match vs campaign, not the object
	        {
	            bot_activation_distance *= 10;
	            bot_deactivation_distance *= 20;
	        }
	        else
	        {
	            bot_activation_distance *= 5;
	            bot_deactivation_distance *= 10;
	        }
        
	        draw_label = false;
	    }
	    player.title = "CPU" + string(player.number);
	}
	else
	{
	    new_guy = instance_create(x,y, player_guy);
	    player.title = "P" + string(player.number);
	}

	my_guy = new_guy;

	new_guy.my_player = player;
	new_guy.my_spawner = self.id;
	new_guy.my_base = self.id;

	new_guy.name = player.name;
	new_guy.control_set = player.control_set;
	new_guy.control_index = player.control_index;
	player.my_guy = new_guy;

	if(!mod_get_state("black_color"))
	{
	    new_guy.my_color = g_red;
	    new_guy.potential_color = new_guy.my_color;
	    new_guy.tint_updated = false;
	    new_guy.slots_absorbed = 1;
	}
	else
	{
	    //new_guy.new_color = g_black;
	}

	new_guy.min_damage = player.handicaps[? "min_damage"];
	new_guy.damage = new_guy.min_damage;

	// CHARGEBALL
	guy_provide_chargeball(new_guy);
	/*
	if(has_level(id, "chargeball", 1))
	{
	    if(!instance_exists(new_guy.charge_ball))
	    {
	        ii = instance_create(x,y,charge_ball_obj);
	        ii.my_guy = new_guy.id;
	        ii.my_player = new_guy.my_player;
	        new_guy.charge_ball = ii;
	    }
	}
	*/

	instance_create(x,y,spawn_effect_obj);

	if(has_view)
	{
	    // SET UP CAMERA

	    player_camera.my_guy = new_guy.id;
	    player_camera.follow_guy = true;
	    player_camera.follow_spawner = false;
	    if(player_camera.id != main_camera_obj.id)
	    {
	        main_camera_obj.cameras[? player.number] = player_camera.id;
	    } 

	    // OVERLAYS
	    //add_player_overlay(score_overlay);
	    if(gamemode_obj.mode != "volleyball" || player.number <= 2)
	    {
	        add_player_overlay(healthbar_overlay, player);
	    }
	    //player.minimap = add_player_overlay(player_minimap_overlay);
	    if(!gamemode_obj.no_inventory)
	        add_player_overlay(inventory_overlay, player);
	    add_player_overlay(overhead_overlay, player);
	    if(mod_get_state("tutorials") && !player.is_cpu)
	        add_player_overlay(tutorial_overlay, player);
	    add_player_overlay(status_effect_overlay, player);
	    add_player_overlay(radial_overlay, player);
	    player.battlefeed = add_player_overlay(battlefeed_overlay, player);   
        
        add_player_overlay(color_info_overlay, player);
	}

	ii = instance_create(x,y,name_plate_window);
	ii.my_guy = new_guy.id;


}
