event_inherited();

if(instance_exists(my_guy.attack_target))
{
    var target_dir = point_direction(x,y, my_guy.attack_target.x, my_guy.attack_target.y);
    var target_diff = angle_difference(target_dir, base_rotation_angle);
    var image_diff = angle_difference(image_angle, base_rotation_angle);
    var angle_diff = angle_difference(target_diff, image_diff);
    
    rel_rotation_angle += sign(angle_diff) * min(max_rotation_speed, abs(angle_diff));
    rel_rotation_angle = clamp(angle_difference(rel_rotation_angle, base_rotation_angle), min_rotation_angle, max_rotation_angle) + base_rotation_angle;
    
    angle_diff = angle_difference(target_dir, image_angle);
    var angle_dist = abs(angle_diff);
    
    if(ready_to_fire && angle_dist < 5)
    {
        var shot_x = lengthdir_x(shot_dist, image_angle);
        var shot_y = lengthdir_y(shot_dist, image_angle);
        var blocker = instance_place(x + shot_x, y + shot_y, equipment_obj);
        
        cant_hit_target = true;
        
        if(!instance_exists(blocker) || blocker.my_player != my_player)
        {
            if(small_projectile_line_of_sight(x + shot_x, y + shot_y, my_guy.attack_target))
            {
                var inst = create_energy_ball(id, "small_bolt", my_color, 0.2);
                inst.x += shot_x;
                inst.y += shot_y;

                inst.direction = image_angle;
                inst.speed = 4;
                inst.guided = true;

                my_color = irandom_range(g_red, g_cyan);
                tint_updated = false;
            
                self.ready_to_fire = false;
                alarm[1] = refire_time;
                cant_hit_target = false;
            }
        }
    }
}
