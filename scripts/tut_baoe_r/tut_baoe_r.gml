function tut_baoe_r() {
	if(npc_active || phase != 0)
	{
	    if(phase == 0)
	    {
	        self.wanna_run = true;
	        facing_right = false;
	        if(current_slot != 0)
	            self.wanna_move = true;
	        if(stuck)
	        {
	            phase = 1;
	        }
	    }
    
	    if(phase == 1)
	    {
	        self.wanna_run = false;
	        facing_right = false;
	        self.wanna_cast = true;
	        phase = 2; 
	    }
	    if(phase == 2)
	    {
	        if(self.charging && charge_ball != noone)
	        {
	            if((charge_ball.charge>0.3 * charge_ball.threshold && random(20)<1) || charge_ball.charge > 0.5 * charge_ball.threshold)
	            {   
	                self.looking_up = true;
	                self.wanna_cast = false;
	                steps_waited = 0;
	                phase = 3;
	            }
	        } 
	    }
	    if(phase == 3)
	    {     
	        steps_waited += 1;
	        if(steps_waited > fps)
	        {
	            if(current_slot == 0)
	            {
	                new_color = g_blue;
	            }
	            phase = 4;
	        }
	    }
	}



}
