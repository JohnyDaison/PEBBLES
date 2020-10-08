function tut_dive() {
	if(npc_active || phase != 0)
	{
	    if(phase == 2)
	    {
	        self.wanna_jump = false;
	        self.looking_down = false;
	        if(!airborne)
	        {
	            facing_right = true;
	            self.have_dived = false;
	            self.wanna_run = true;
	            if(stuck)
	            {
	                steps_waited = 0;
	                self.wanna_run = false;
	                phase = 0;
	            }
	        }
	    }    

	    if(phase == 1)
	    {
	        steps_waited += 1;
	        if(steps_waited > 14)
	        {
	            self.wanna_run = false;
	            self.looking_down = true;
	            self.have_jumped = false;
	            phase = 2;
	        }
	    }
    
	    if(phase == 0)
	    {
	        steps_waited += 1;
	        self.wanna_run = true;
	        facing_right = false;
	        if(steps_waited > 30)
	        {
	            self.wanna_jump = true;
	            steps_waited = 0;
	            phase = 1;
	        }
	    }
	}



}
