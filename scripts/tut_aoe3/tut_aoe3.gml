function tut_aoe3() {
	self.looking_down = true;

	if(damage != last_damage)
	{
	    npc_active = true;
	}

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
	            if(charge_ball.charge>0.4 && random(20)<1)
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
	            phase = 0;
	            npc_active = false;
	        }
	    }
	}
	last_damage = damage;



}
