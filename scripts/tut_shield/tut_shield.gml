function tut_shield() {
	if(npc_active || phase != 0)
	{
	    if(phase == 0)
	    {
	        var new_color = 3;
	        while(new_color == 3)
	        {
	            new_color = irandom(3)+1;
	        }
	        ds_list_add(new_colors, new_color);
	        if(current_slot == irandom(3)+1)
	        {
	            self.wanna_cast = true;
	            phase = 1;
	        } 
	    }
	    if(phase == 1)
	    {
	        if(self.charging && charge_ball != noone)
	        {
	            if(charge_ball.charge > 0.5 * charge_ball.threshold && random(20)<1)
	            {
	                self.wanna_cast = false;
	                phase = 2;
	            }
	        } 
	    }
	    if(phase == 2)
	    {
	        if(my_shield != noone)
	        {
	            if(my_shield.charge==my_shield.max_charge && random(40)<1)
	            {
	                phase = 0;
	            }
	        }
	        else
	            phase = 0;  
	    }
	}



}
