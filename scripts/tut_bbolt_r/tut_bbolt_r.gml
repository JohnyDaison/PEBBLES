function tut_bbolt_r() {
	if(npc_active || phase != 0)
	{
	    if(phase == 0)
	    {
	        self.wanna_run = true;
	        self.hor_dir_held = true;
	        facing_right = true;
	        if(stuck)
	        {
	            phase = 1;
	        }
	    }
    
	    if(phase == 1)
	    {
	        self.wanna_run = false;
	        self.facing_right = false;
	        self.wanna_cast = true;
	        self.wanna_look = true;
	        phase = 2; 
	    }
	    if(phase == 2)
	    {
	        if(self.charging && charge_ball != noone)
	        {
	            if(charge_ball.charge > 0.9 * charge_ball.threshold && random(20)<1)
	            {   
	                self.wanna_cast = false;
	                dist_covered = 0;
	                steps_waited = 0;
	                phase = 3;
	            }
	        } 
	    }
	    if(phase == 3)
	    {     
	        dist_covered += abs(hspeed);
	        if(dist_covered > 128)
	        {
	            self.wanna_jump = true;
	            self.wanna_look = false;
	            steps_waited += 1;
	        }
	        if(current_slot != 0 || (steps_waited > 3*fps))
	        {
	            self.wanna_jump = false;
	            phase = 4;
	            if(current_slot == 0)
	            {
	                ds_list_add(new_colors, g_blue);
	                forced_channel = true;
	            }
	        }
	    }
	}



}
