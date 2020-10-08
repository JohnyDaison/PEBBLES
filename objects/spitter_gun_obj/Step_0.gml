event_inherited();

if(instance_exists(my_guy.attack_target))
{
    target_dir = point_direction(x,y, my_guy.attack_target.x, my_guy.attack_target.y);
    /*
    angle_dist = abs((image_angle mod 360) - target_dir);

    if(angle_dist > 180)
    {
        angle_dist = abs(angle_dist - 360);
    }
    */
    /*
    var full_stop_time = ceil(0.5*rel_rotation_speed/rel_rotation_acc);
    var next_angle = image_angle + full_stop_time*rel_rotation_speed;
    
    angle_diff = angle_difference(next_angle, target_dir);
    */
    //angle_diff = angle_difference(image_angle, target_dir);
    //angle_diff = angle_difference(target_dir, image_angle);
    //rel_rotation_angle += sign(angle_diff) * min(max_rotation_speed, abs(angle_diff));
    
    
    var target_diff = angle_difference(target_dir, base_rotation_angle);
    var target_dist = abs(target_diff);
    //if(target_dist < 90)
    //{
        var image_diff = angle_difference(image_angle, base_rotation_angle);
        var image_dist = abs(image_diff);
        angle_diff = angle_difference(target_diff, image_diff);
        rel_rotation_angle += sign(angle_diff) * min(max_rotation_speed, abs(angle_diff));
    //}
    
    
    //rel_rotation_angle = angle_difference(rel_rotation_angle, 0);
    
    //rel_rotation_angle = angle_difference(clamp(angle_difference(rel_rotation_angle, base_rotation_angle), min_rotation_angle, max_rotation_angle) + base_rotation_angle, 0);
    rel_rotation_angle = clamp(angle_difference(rel_rotation_angle, base_rotation_angle), min_rotation_angle, max_rotation_angle) + base_rotation_angle;
    
    
    /*
    rel_rotation_delta = -sign(angle_diff) * min(rel_rotation_acc, abs(angle_diff));
    
    if(abs(rel_rotation_speed) > max_rotation_speed)
    {
        rel_rotation_speed = sign(rel_rotation_speed) * max_rotation_speed;
    }
    */
    
    angle_diff = angle_difference(target_dir, image_angle);
    angle_dist = abs(angle_diff);
    
    if(ready_to_fire && angle_dist < 5)
    {
        var shot_x = lengthdir_x(shot_dist, image_angle);
        var shot_y = lengthdir_y(shot_dist, image_angle);
        var blocker = instance_place(x + shot_x, y + shot_y, equipment_obj);
        
        cant_hit_target = true;
        
        if(!instance_exists(blocker) || blocker.my_player != my_player)
        {
            if(small_projectile_line_of_sight(x+shot_x, y+shot_y, my_guy.attack_target))
            {
                inst = create_energy_ball(id, "small_bolt", my_color, 0.2);
                inst.x += shot_x;
                inst.y += shot_y;
            
                //inst = instance_create(shot_x,shot_y,small_projectile_obj);
                //inst.my_color = irandom_range(1,6);
                inst.direction = image_angle;
                inst.speed = 4;
                //inst.hspeed += my_guy.hspeed;
                //inst.vspeed += my_guy.vspeed;
                //inst.force = 0.34;
                //inst.my_guy = my_guy.id;
                //inst.my_source = object_index;
                inst.guided = true;
                /*
                inst.was_stopped = true;
                inst.gravity = inst.gravity_coef;
                */
            
                my_color = irandom_range(g_red, g_azure);
                tint_updated = false;
            
                self.ready_to_fire = false;
                alarm[1] = refire_time;
                cant_hit_target = false;
            }
        }
    }
}

