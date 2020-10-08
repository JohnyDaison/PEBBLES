function goto_tutorial() {
	//display_reset(0, true);
	DB.player_num = 0;

	campaign = instance_create(0,0,campaign_obj);
	//campaign.starting_slots = 3;
	campaign.world = instance_create(0,0,world_1_obj);
	campaign.arena_name = campaign.world.current_place.name;
	campaign.mode = "training";
	campaign.name = "Training";


	//player_levels_give_hack(campaign.environment);

	player = instance_create(0,0,player_obj);
	player.number = 1;
	player.control_set = keyboard1;
	player.control_index = 10;
	player.name = "Player";
	player.flag = "number1_flag";
	//player.icon = DB.bf_icon_map[? player.flag];

	with(gamepad_input_obj)
	{
	    if(on && index < other.player.control_index) {
	        other.player.control_set = gamepad;
	        other.player.control_index = index;
	    }
	}

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

	ds_map_add(campaign.players,1,player.id);
	campaign.player_count = 1;

	room_goto(campaign.world.current_place.room_id);



}
