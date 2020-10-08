function guide_walljump(argument0) {
	var near_player = argument0;
	var pl_dist = 0, pl_has_skill = false;
	var facing_wall = false, jump_charged = false;
	if(instance_exists(near_player))
	{
	    pl_dist = point_distance(x,y, near_player.x, near_player.y);
	    pl_has_skill = has_level(near_player, "wall_climb", 1);
	}

	if(ready_to_show_moves)
	{
	    facing_wall = place_meeting(x+facing, y, terrain_obj);
	    jump_charged = self.jumping_charge == jumping_max_charge;
	}

	switch(phase)
	{
	    case 0:
	        npc_resting = false;
	        if(pl_dist < 128)
	        {
	            if(!speaking)
	            {
	                if(!pl_has_skill)
	                {
	                    speech_start("tut_guide/lvl1.gloves");
	                    phase = 1;
	                }
	                else
	                {
	                    speech_start("bark/follow_me1");
	                    ready_to_show_moves = true;
	                    phase = 1;       
	                }
	            }  
	        }

	        break;
        
	    case 1:
    
	        if(!speaking)
	        {
	            phase = 2;
	        }

	        break;
        
	    case 2:
    
	        if(!npc_resting)
	        {
	            npc_resting = true;
	            npc_rest_start = singleton_obj.step_count;
	        }
        
	        if((singleton_obj.step_count - npc_rest_start) > npc_rest_time)
	        {
	            npc_resting = false;
	            if(!ready_to_show_moves)
	            {
	                phase = 0;
	            }
	            else
	            {
	                phase = 3;
	            }
	        }
        
	        break;
        
	    case 3:

        
	        if(holding_wall)
	        {
	            wanna_run = true;
	            if(have_jumped)
	            {
	                wanna_jump = false;
	                have_jumped = false;   
                
	                npc_resting = true;
	                npc_wallhold_start = singleton_obj.step_count;
	                npc_wanna_walljump = irandom(1);
	            }
	            else
	            {
	                if(npc_wanna_walljump && (singleton_obj.step_count - npc_wallhold_start) > npc_wallturn_time)
	                { 
	                    if(facing_wall)
	                    {
	                        facing_right = !facing_right;
	                    }
	                }
	                if((singleton_obj.step_count - npc_wallhold_start) > npc_wallhold_time)
	                {   
	                    wanna_jump = true;
	                }
	            }
	        }
	        else if(!airborne)
	        {
	            wanna_run = !facing_wall;
            
	            if(!wanna_jump)
	            {
	                wanna_jump = true;
	                have_jumped = false;
	            }
	            else if(jump_charged)
	            {
	                wanna_jump = false;
	            }
	        }
	        else
	        {
	            if(vspeed > gravity)
	            {
	                wanna_jump = true;
	                if(facing_wall && doublejump_count >= 1)
	                {
	                    wanna_run = true;   
	                }
	            }
	            else
	            {
	                wanna_jump = false;
	                have_jumped = false;
	            }
	        }
        
	        break;
	}



}
