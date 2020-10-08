function guide_welcome1(argument0) {
	var near_player = argument0;
	var pl_dist = 0;
	if(instance_exists(near_player))
	{
	    pl_dist = point_distance(x,y, near_player.x, near_player.y);
	}

	switch(phase)
	{
	    case 0:
    
	        npc_walking = false;
	        npc_resting = false;
	        if(pl_dist < 128 && !speaking)
	        {
	            speech_start("tut_guide/lvl1.first_task");
	            phase = 1;
	        }
	        else
	        {
	            phase = 2;
	        }

	        break;
        
	    case 1:
    
	        if(!speaking)
	        {
	            if(facing_right)
	            {
	                casting = true;
	                casting_hor = true;
	            }
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
	            phase = 3;
	        }
        
	        break;
        
	    case 3:

	        if(!npc_walking)
	        {
	            facing_right = !facing_right;
	            facing *= -1;
	            npc_walking = true;
	            npc_walk_start = singleton_obj.step_count;
	        }
        
	        if((singleton_obj.step_count - npc_walk_start) > npc_walk_time)
	        {
	            phase = 0;
	        }
	        else
	        {
	            if(abs(hspeed) < npc_walk_speed && sign(hspeed) != -facing)
	            {
	                wanna_run = true;
	            }
	            else
	            {
	                wanna_run = false;   
	            }
	        }
        
	        break;
	}



}
