/// @description chargeball_orbs_draw(charge_ball_obj)
/// @function chargeball_orbs_draw
/// @param charge_ball_obj
function chargeball_orbs_draw(argument0) {
	var ball = argument0;

	if(instance_exists(ball) && instance_exists(ball.my_guy))
	{
	    with(ball)
	    {
	        var ii, col, orb, tries, orbs_to_draw = my_guy.slots_absorbed - orb_count;
	        //show_debug_message("draw orbs start: " + string(orbs_to_draw));
    
	        comp = color_to_components(my_guy.my_color);
	        //show_debug_message("num_colors_used: " + string(num_colors_used));
	        var cols_left = num_colors_used;
    
	        for(ii = 0; ii < orb_count; ii++)
	        {
	            orb = orbs[| ii];
	            col = orb.my_color;
        
	            if(comp[col])
	            {
	                comp[col] = 0;
	                cols_left--;
	            }
	        }
	        //show_debug_message("cols_left: " + string(cols_left));
    
	        if(cols_left > orbs_to_draw)
	        {
	            chargeball_orbs_return(id);
	            orbs_to_draw = my_guy.slots_absorbed;
	            comp = color_to_components(my_guy.my_color);
	            cols_left = num_colors_used;
	            orbs_to_draw = max(orbs_to_draw, num_colors_used);
	        }    
    
	        //show_debug_message("draw orbs final: " + string(orbs_to_draw));
    
    
	        for(col = g_black; col <= g_blue; col++)
	        {
	            if(col == g_yellow)
	                continue;
        
	            if(comp[col])
	            {
	                cols_left--;
               
	                var belt = my_guy.orb_belts[? col];
            
	                tries = max_orbs;
	                while(orbs_to_draw > cols_left && tries > 0)
	                {
	                    orb = belt[|0];
            
	                    if(!is_undefined(orb) && instance_exists(orb))
	                    {
	                        orb_transfer(orb, my_guy, "belt", id, "orbit");
	                        orbs_to_draw--;
	                        //show_debug_message("orbs left: " + string(orbs_to_draw));
	                    }
                
	                    tries--;
	                }
	            }   
	        }   
	    }
	}


}
