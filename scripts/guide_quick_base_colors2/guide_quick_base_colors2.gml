///@param method
///@param [near_guy]
///@param [selected_subtask]
function guide_quick_base_colors2() {
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
	        main_quest_id = "quick_tutorial_base_colors";
	        main_context = "quick_tut_level2";
        
	        set_my_color(g_white);
	        npc_auto_demonstrate = true;
        
	        break;
        
        
	    case "demo_after_speech":
	        if(selected_subtask == "green_orbit" || selected_subtask == "green_body")
	        {
	            if(current_slot == 0 && !slots_triggered && my_color != g_green)
	            {
	                ds_list_add(new_colors, g_green);
	                self.auto_chosen_orbs = true;
	            }
	        }
    
	        if(selected_subtask == "green_body")
	        {
	            if(my_color != g_green)
	            {
	                wanna_cast = true;
	            }
	        }
        
	        if(selected_subtask == "blue_body")
	        {
	            if(current_slot == 0)
	            {
	                ds_list_add(new_colors, g_blue);
	                self.auto_chosen_orbs = true;
	            }
	        }
        
	        if(selected_subtask == "blue_wall_climb")
	        {
	            if(my_color != g_blue)
	            {
	                ds_list_add(new_colors, g_blue);
	                self.auto_chosen_orbs = true;
	                wanna_cast = true;
	            }
	        }
        
	        if(selected_subtask == "hp_bar")
	        {
	            with(healthbar_overlay)
	            {
	                if(my_guy == near_player_guy && own_hp_blink_time == 0)
	                {
	                    own_hp_blink_rate = 20;
	                    own_hp_blink_time = own_hp_blink_rate*4;
	                }
	            }
	        }
        
	        break;
        
	    case "non_demo":
	        if(selected_subtask == "red_body")
	        {
	            if(my_color != g_red)
	            {
	                ds_list_add(new_colors, g_red);
	                self.auto_chosen_orbs = true;
	                wanna_cast = true;
	            }
	        }
    
	        break;
	}



}
