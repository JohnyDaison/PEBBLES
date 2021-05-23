event_inherited();

if(ready_to_fire && instance_exists(my_guy.attack_target))
{
    var target_dir = point_direction(my_guy.x, my_guy.y, my_guy.attack_target.x, my_guy.attack_target.y);
    var angle_dist = abs((image_angle mod 360) - target_dir);

    if(angle_dist > 180)
    {
        angle_dist = abs(angle_dist - 360);
    }
    if(angle_dist < 90)
    {
        var shot_x = lengthdir_x(shot_dist, image_angle);
        var shot_y = lengthdir_y(shot_dist, image_angle);
        var blocker = instance_place(x + shot_x, y + shot_y, equipment_obj);
        
        if(!instance_exists(blocker) || blocker.my_player != my_player)
        {
            var inst = create_energy_ball(id, "small_bolt", irandom_range(g_red,g_cyan), 0.34);
            inst.x += shot_x;
            inst.y += shot_y;
            
            inst.direction = image_angle;
            inst.speed = 7;
            inst.guided = true;
            inst.guy_lockon_range = 384;
            
            self.ready_to_fire = false;
            alarm[1] = refire_time;
        }
    }
}
