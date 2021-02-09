function status_overcharge_end() {
	if(ball_overcharge >= 1)
	    ball_overcharge -= 1;
    
	if(instance_exists(charge_ball))
	{
	    charge_ball.charge = min(charge_ball.charge,
	        charge_ball.max_charge + charge_ball.overcharge - 1);
	}
}
