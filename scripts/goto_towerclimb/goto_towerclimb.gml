function goto_towerclimb() {
	//display_reset(0, true);
	DB.player_num = 0;

	campaign = instance_create(0,0,campaign_obj);
	with(campaign)
	{
	    levels_load_config("match");
	    config_level_gamemode("rewind", "", "", 0);
	    config_level_gamemode("teleport", "", "", 0);
	    snakes_on_a_plane = true;
	}
	//campaign.starting_slots = 3;
	campaign.world = instance_create(0,0,towerclimb_world);
	campaign.arena_name = campaign.world.current_place.name;

	/*
	player = instance_create(0,0,player_obj);
	player.number = 1;
	player.control_set = keyboard1;
	player.control_index = 10;
	player.name = "Player";

	with(gamepad_input_obj)
	{
	    if(on && index < other.player.control_index) {
	        other.player.control_set = gamepad;
	        other.player.control_index = index;
	    }
	}
	*/

	var input_method = gamepad;

	// PLAYERS
	var player1 = instance_create(0,0,player_obj);
	player1.number = 1;
	player1.icon = icon_1_spr;
	player1.name = "Johny Daison";
	if(input_method != gamepad) {
	    player1.control_set = 2*input_method + 1;
	}
	else {
	    player1.control_set = input_method;
	    player1.control_index = 0;
	}
	player1.handicaps[? "min_damage"] = 3; // MISSING HP, not max!

	ds_map_add(campaign.players, 1, player1.id);

	var player2 = instance_create(0,0,player_obj);
	player2.number = 2;
	player2.icon = icon_2_spr;
	player2.name = "CyberLabs";
	if(input_method != gamepad) {
	    player2.control_set = 2*input_method + 2;
	}
	else {
	    player2.control_set = input_method;
	    player2.control_index = 1;
	}

	ds_map_add(campaign.players, 2, player2.id);

	campaign.player_count = 2;

	with(player_obj)
	{
	    switch(control_set)
	    {
	        case keyboard1:
	        {
	            control_obj = keyboard1_obj.id;
	            break;      
	        }
	        case keyboard2:
	        {
	            control_obj = keyboard2_obj.id;
	            break;              
	        }
	        case joypad1:
	        {
	            control_obj = joystick1_obj.id;
	            break;
	        }
	        case joypad2:
	        {
	            control_obj = joystick2_obj.id;
	            break;
	        }
	        case gamepad:
	        {
	            with(gamepad_input_obj)
	            {
	                if(index == other.control_index)
	                {
	                    other.control_obj = id;
	                }
	            }
	            break;
	        }
	    }
	}
	/*
	ds_map_add(campaign.players,1,player.id);
	campaign.player_count = 1;
	*/
	/*
	player = instance_create(0,0,player_obj);
	player.number = 2;
	player.name = "Nobody";
	player.control_set = keyboard2;
	ds_map_add(campaign.players,2,player);
	*/
	/*
	death_limit_index = 2;
	ds_map_replace(campaign.limits,"deaths",1);

	for(i=0;i<DB.limit_count;i+=1)
	{
	    campaign.limit_active[? limit_name] = (i==death_limit_index);
	}
	*/

	room_goto(campaign.world.current_place.room_id);



}
