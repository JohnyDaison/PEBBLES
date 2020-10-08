///@param method
///@param [near_guy]
///@param [selected_subtask]
function guide_quick_movement2() {
	var pseudo_method = argument[0];
	var near_player_guy = noone;
	var selected_subtask = "";

	if(argument_count > 1)
	{
	    near_player_guy = argument[1];   
	}
	if(argument_count > 2)
	{
	    selected_subtask = argument[2];   
	}

	switch(pseudo_method)
	{
	    case "init":
	        main_quest_id = "quick_tutorial_movement";
	        main_context = "quick_tut_level1";
        
	        set_my_color(g_green);
	        npc_auto_demonstrate = true;
	        npc_autospeak = true;
        
	        break;
        
        
	    case "demo_after_speech":
    
	        if(selected_subtask == "wall_jump")
	        {
	            npc_wallhold_time = 45;
	        }
        
	        break;
        
	    case "non_demo":
    
	        if(selected_subtask == "welcome" || selected_subtask == "intro")
	        {
	            with(guy_obj)
	            {
	                if(id != other.id)
	                {
	                    locked = true;    
	                }
	            }
	        }
        
	        if(selected_subtask == "intro_exit")
	        {
	            /*
	            if(x < room_width/2)
	            {
	                var group = get_group("waypoints");
	                npc_waypoint = "intro_exit/success";
                
	                var wp = group_find_member(group, npc_waypoint);
	                npc_destination_reached = false;
	                npc_destination_x = wp.x;
	                npc_destination_y = wp.y;
	                npc_destination = wp;
            
	                npc_waypoint_x = wp.x;
	                npc_waypoint_y = wp.y;
	            }
	            */
	        }
    
	        break;
	}



}
