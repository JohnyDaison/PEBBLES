/// @description NORMAL mode
if(instance_exists(my_guy) && my_guy != self.id)
{
    var projectile = other.id;
    var shield = id;
    var not_octarine = projectile.my_color != g_octarine;
    
    if(not_octarine && projectile.my_player.team_number == my_player.team_number && is_undefined(projectile.has_left_inst[? id]))
    {
        if(was_meeting_me(projectile))
        {
            with(projectile)
            {
                has_left_update(shield, false);
            }
        }
        else
        {
            with(projectile)
            {
                has_left_update(shield, true);
            }
        }
    }
    
    if((projectile.my_player.team_number != my_player.team_number || has_left_me(projectile)) && self.holographic == projectile.holographic)
    {
        if(my_color == projectile.my_color && not_octarine)
        {
            if(radius < bounce_radius_threshold && !projectile.was_stopped)
            {
                with(projectile)
                {
                    if(!immovable)
                    {
                        move_bounce_all(false);
                        speed = max(0, speed - 0.2);
                    }
                    my_sound_play(wall_hum_sound);
                    //my_sound_play_colored(wall_hum_sound, my_color)
                }
            }
            else
            {
                if(!projectile.immovable)
                {
                    apply_force(projectile, true);
                }
            }
            
            if(gamemode_obj.mode == "volleyball")
            {
                my_player.touching_ball = true;
            }
        }
        else
        {
            with(projectile)
            {
                with(shield.my_guy)
                {
                    receive_damage(projectile.force);
                }
            }
        }
    }
}