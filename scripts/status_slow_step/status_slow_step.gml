function status_slow_step() {
	if(abs(hspeed) > self.slowed_maxspeed)
	{
	    if(!lost_control && !airborne && !skidding)
	    {
	        hspeed -= friction*sign(hspeed);
	    }
	}
	// also see my_guy - running



}
