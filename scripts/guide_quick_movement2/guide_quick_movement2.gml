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
                with(guide_spawner_obj)
                {
                    introduction_finished = false;
                }
            }
            
            if(selected_subtask == "intro_exit")
            {
                with(guide_spawner_obj)
                {
                    introduction_finished = true;
                }
            }
    
            break;
    }
}
