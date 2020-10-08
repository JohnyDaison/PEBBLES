function tut_jump() {
	if(npc_active || phase != 0)
	{
	    if(phase == 2)
	    {
	        if(!airborne)
	        {
	            facing_right = true;
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
	        if(steps_waited > jump_length)
	        {
	            self.wanna_jump = false;
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
	            jump_length = random(10)+10;
	        }
	    }
	}



}
