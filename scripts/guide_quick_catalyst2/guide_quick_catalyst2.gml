///@param method
///@param [near_guy]
///@param [selected_subtask]
function guide_quick_catalyst2() {
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
	        main_quest_id = "quick_tutorial_catalyst";
	        main_context = "quick_tut_level3";
        
	        npc_auto_demonstrate = true;
        
	        break;
        
        
	    case "demo_after_speech":
	        if(selected_subtask == "color_body" || selected_subtask == "quick_shot")
	        {
	            if(my_color == g_black || (tint_updated && !slots_triggered && !charging && !casting))
	            {
	                ds_list_add(new_colors, choose(g_red, g_green, g_blue));
	                self.auto_chosen_orbs = true;
	                wanna_cast = true;
	            }
	        }
            
	        if(selected_subtask == "quick_shot")
	        {
	            if(my_color != g_black)
	            {
	                var target = instance_nearest(x,y, SECRET_obj);
                    
	                if(instance_exists(target))
	                {
	                    desired_aim_dir = point_direction(x,y, target.x, target.y);
	                    desired_aim_dist = 1;
                    
	                    if(!casting && charge_ball.energy < 0.2)
	                    {
	                        wanna_cast = true;
	                    }
	                }
	            }
	        }
            
	        if(selected_subtask == "jump_to_slimes")
	        {
	            if(my_color != g_red)
	            {
	                ds_list_add(new_colors, g_red);
	                self.auto_chosen_orbs = true;
	                wanna_cast = true;
	            }
	        }
        
	        if(selected_subtask == "be_out_of_range")
	        {
	            if(my_color == g_black || (!charging && !casting))
	            {
	                ds_list_add(new_colors, choose(g_red, g_green, g_blue));
	                self.auto_chosen_orbs = true;
	            }
            
	            wanna_cast = true;
	            wanna_look = true;
	            desired_aim_dir = 0;
	            desired_aim_dist = 1;
	            set_guy_facing(true);
	        }
        
	        if(selected_subtask == "battery_spawner")
	        {
	            if(my_color == g_black || (!charging && !casting))
	            {
	                ds_list_add(new_colors, choose(g_red, g_green, g_blue));
	                self.auto_chosen_orbs = true;
	            }
            
	            if(!casting && charge_ball.energy < 0.2)
	            {
	                wanna_cast = true;
	            }
            
	            wanna_look = true;
	            desired_aim_dir = 0;
	            desired_aim_dist = 1;
	            set_guy_facing(true);
	        }
        
	        break;
        
	    case "non_demo":
    
	        break;
	}



}
