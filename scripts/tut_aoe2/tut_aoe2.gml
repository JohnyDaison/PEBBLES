function tut_aoe2() {
	if(npc_active || phase != 0)
	{
	    if(phase == 0)
	    {
	        new_color = 3;
	        while(new_color == 3)
	        {
	            new_color = round(random(3))+1;
	        }
	        if(current_slot == round(random(3)))
	        {
	            self.wanna_cast = true;
	            phase = 1;
	        } 
	    }
	    if(phase == 1)
	    {
	        if(self.charging && charge_ball != noone)
	        {
	            if(charge_ball.charge>0.4 && random(60)<1)
	            {   
	                if(looking_up)
	                {
	                    looking_up = false;
	                    looking_down = true;
	                }
	                else
	                {
	                    looking_up = true;
	                    looking_down = false;
	                }
	                self.wanna_cast = false;
	                phase = 2;
	            }
	        } 
	    }
	    if(phase == 2)
	    {
	        if(!self.charging && !self.casting)
	        {
	            phase = 0;
	        }
	    }
	}



}
