/// @description apply_force(target, repel, [ignore_my_stuff], [coef])
/// @function apply_force
/// @param target
/// @param repel
/// @param [ignore_my_stuff]
/// @param [coef]
function apply_force() {
	var target = argument[0];
	var repel = argument[1];
	var ignore_my_stuff = false;
	var coef = 1;

	var target_ok, force_x, force_y, force_sign, force_dir, dist, dist_ratio;

	if(argument_count > 2)
	{
	    ignore_my_stuff = argument[2];
	}

	if(argument_count > 3)
	{
	    coef = argument[3];
	}

	if(!instance_exists(target))
	{
	    return false;
	}

	if(ignore_my_stuff)
	{
	    if(my_player == target.my_player && my_player != noone && my_player != gamemode_obj.environment)
	    {
	        target_ok = false;
	    }
	    else
	    {
	        target_ok = true;
	    }
	}
	else
	{
	    target_ok = true;
	}

	if(target_ok)
	{
	    if(repel)
	    {
	        force_sign = 1;
	    }
	    else
	    {
	        force_sign = -1;
	    }
    
	    var terrain_type = terrain_obj;
    
	    if(object_is_child(target, projectile_obj) || target.object_index == slime_mob_obj)
	    {
	        terrain_type = solid_terrain_obj;
	    }
    
	    switch(shape)
	    {
	        case shape_circle:
        
	        with(target)
	        {
	            force_dir = point_direction(other.x,other.y,x,y);
	            dist = point_distance(other.x,other.y,x,y);
	            if(dist != 0)
	            {
	                dist_ratio = sqrt(other.field_focus/dist);
	                var total_force = coef*force_sign*other.field_power*dist_ratio;
	                var x_force = lengthdir_x(total_force, force_dir);
	                var y_force = lengthdir_y(total_force, force_dir);
                
	                var orig_x = x + hspeed;
	                var orig_y = y + vspeed;
	                var new_x = orig_x + x_force;
	                var new_y = orig_y + y_force;
                
	                if(!place_meeting(new_x, new_y, terrain_type))
	                {
	                    hspeed += x_force;
	                    vspeed += y_force;
	                }
	                else if(!place_meeting(new_x, orig_y, terrain_type))
	                {
	                    hspeed += x_force;
	                }
	                else if(!place_meeting(orig_x, new_y, terrain_type))
	                {
	                    vspeed += y_force;
                    
	                    if(object_is_child(other, structure_obj) && other.immovable
	                    && object_is_child(id, phys_body_obj)
	                    && sign(y_force) == -1)
	                    {
	                        vspeed -= gravity;
	                    }
	                }
                
	                if(speed > max_speed)
	                {
	                    speed = max_speed;   
	                }
	            }
	        }
        
	        break;
        
	        case shape_rect:
        
	        with(target)
	        {
	            var x_dist = x - other.x;
	            var y_dist = y - other.y;
            
	            var x_perim_dist = x_dist - sign(x_dist)*(other.width/2);
	            var y_perim_dist = y_dist - sign(y_dist)*(other.height/2);
            
	            if(sign(x_perim_dist) == sign(x_dist) && x_dist != 0)
	            {
	                force_y = sign(y_dist)*sqrt(1/abs(x_perim_dist));
	            }
	            else
	            {
	                force_y = sign(y_dist);
	            }
            
	            if(sign(y_perim_dist) == sign(y_dist) && y_dist != 0)
	            {
	                force_x = sign(x_dist)*sqrt(1/abs(y_perim_dist));
	            }
	            else
	            {
	                force_x = sign(x_dist);
	            }
            
	            force_dir = point_direction(0,0,force_x,force_y); 
	            dist_ratio = point_distance(0,0,force_x,force_y);
            
	            var total_force = force_sign*other.field_power*dist_ratio;
	            var new_x = x+hspeed+lengthdir_x(total_force, force_dir);
	            var new_y = y+vspeed+lengthdir_y(total_force, force_dir);
	            if(!place_meeting(new_x, new_y, terrain_obj))
	            {
	                motion_add(force_dir, total_force);
	            }
	        }
        
	        break;
	    }
    
	    if(repel)
	    {
	        my_sound_play(wall_hum_sound);
	        //my_sound_play_colored(wall_hum_sound, my_color);
	    }
    
	    with(target)
	    {
	        if(gives_light)
	        {
	            light_boost *= 1.5;
	        }
	    }
	}



}
