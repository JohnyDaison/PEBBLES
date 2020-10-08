///@param method
///@param [near_guy]
///@param [selected_subtask]
function guide_movement2() {
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
	        main_quest_id = "tutorial_movement";
	        main_context = "tut_level1";
        
	        set_my_color(g_green);
        
	        break;
        
        
	    case "demo_after_speech":
	        if(selected_subtask == "wall_jump")
	        {
	            npc_wallhold_time = 45;
	        }
        
	        break;
        
	    case "non_demo":
    
	        break;
	}



}
