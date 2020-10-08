/// @description chargeball_orbs_return(charge_ball_obj)
/// @function chargeball_orbs_return
/// @param charge_ball_obj
function chargeball_orbs_return(argument0) {
	var ball = argument0;
	var i, cb_orb;

	if(instance_exists(ball) && instance_exists(ball.my_guy) && ds_exists(ball.orbs, ds_type_list))
	{
	    ball.orb_count = ds_list_size(ball.orbs);
	    for(i=ball.orb_count-1; i>=0; i--)
	    {
	        cb_orb = ball.orbs[|i];
	        orb_transfer(cb_orb, ball, "orbit", ball.my_guy, "belt");
	    }
	}




}
