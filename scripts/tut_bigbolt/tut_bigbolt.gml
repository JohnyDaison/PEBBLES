function tut_bigbolt() {
	facing_right = false;

	if(npc_active || phase != 0)
	{
	    if(phase == 0)
	    {
	        var new_color = 3;
	        while(new_color == 3)
	        {
	            new_color = round(random(3))+1;
	        }
	        ds_list_add(new_colors, new_color);
	        self.wanna_look = true;
	        self.wanna_cast = true;
	        self.hor_dir_held = true;
	        phase = 1;
	    }
	    if(phase == 1)
	    {
	        if(self.charging && charge_ball != noone)
	        {
	            if(charge_ball.charge > 0.75 * charge_ball.threshold && random(10)<1)
	            {   
	                self.wanna_cast = false;
	                phase = 2;
	            }
	        } 
	    }
	    if(phase == 2)
	    {
	        if(!self.charging && !self.casting)
	        {
	            self.wanna_look = false;
	            phase = 0;
	        }
	    }
	}



}
