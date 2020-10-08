function beam_turret_line_of_sight() {
	var target = id;

	with(other)
	{
	    if(iff_check("attack_target_valid", id, target) && !target.protected && !self.fire)
	    {
	        if(sign(target.x-x) == facing
	        && target.bbox_top < y && target.bbox_bottom > y)
	        {
	            var check_x = charge_ball.x;
	            var check_y = charge_ball.y;
	            if(!collision_line(check_x,check_y,target.x,target.y, solid_terrain_obj, false, false))
	            {
	                fire = true;
	                target_dir = facing;
	            }
	        }
	    }
	}



}
