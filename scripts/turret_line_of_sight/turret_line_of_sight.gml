/// @description turret_line_of_sight() [exports: fire,target_dir]
/// @function turret_line_of_sight
function turret_line_of_sight() {
	var target = id;
	var turret_mount = other;

	with(turret_mount)
	{
	    if(iff_check("attack_target_valid", id, target) && !target.protected && !self.fire)
	    {
	        var xx = x, yy = y, shot_radius = 2;
        
	        var base_dir;
        
	        if(object_is_ancestor(object_index, turret_obj))
	        {
	            base_dir = direction;
	            shot_radius = self.shot_radius;
	            if(self.turret.object_index == charge_ball_obj) 
	            {
	                xx += self.turret.center_offset_x;
	                yy += self.turret.center_offset_y;
	            }
	        }
	        else 
	        {
	            // medium turret calls this from body, not mount
	            base_dir = my_mount.direction;
	            shot_radius = my_mount.shot_radius;
	        }
        
        
	        var dist = point_distance(xx,yy, target.x,target.y);
        
	        if(dist < self.my_range)
	        {
	            var x_offset = 0, y_offset = 0, blocked = noone, check_x, check_y, target_x, target_y, rep;
            
	            var dir = point_direction(xx,yy, target.x,target.y);

	            rep = 0;
            
	            repeat(3)
	            {
	                if(rep == 1)
	                {
	                    x_offset = lengthdir_x(shot_radius, dir+90);
	                    y_offset = lengthdir_y(shot_radius, dir+90);
	                }
	                else if(rep == 2)
	                {
	                    x_offset = lengthdir_x(shot_radius, dir-90);
	                    y_offset = lengthdir_y(shot_radius, dir-90);
	                }
                
	                check_x = xx + x_offset;
	                check_y = yy + y_offset;
                
	                /*
	                target_x = target.x;
	                target_y = target.y;
	                */
	                target_x = target.x + x_offset;
	                target_y = target.y + y_offset;
            
	                blocked = blocked || collision_line(check_x,check_y, target_x,target_y, solid_terrain_obj, false, false);
            
	                blocked = blocked || (( !instance_exists(self.my_player.my_guy) || self.my_player.my_guy.holographic == self.holographic )
	                                  && collision_line(check_x,check_y, target_x,target_y, self.my_player.my_guy, false, false) );
                                  
	                //blocked = blocked || collision_line(check_x,check_y, target_x,target_y, perma_wall_structure_obj, false, false);
            
	                blocked = blocked || collision_line(check_x,check_y, target_x,target_y, cannon_base_obj, false, false);
            
	                rep++;
                
	                if(blocked)
	                {
	                    break;   
	                }
	            }
            
	            if(!blocked)
	            {
	                fire = true;
	                target_dir = dir;
	            }
	        }
	    }
	}



}
