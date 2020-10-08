if(instance_exists(my_guy) && my_guy != self.id)
{
    var projectile = other.id;
    var blade = id;
    
    with(projectile)
    {
        if(is_undefined(has_left_inst[? blade]))
        {
            if(blade.my_player == my_player)
            {
                has_left_update(blade, false);
            }
        }
    }
    
    if(self.holographic == projectile.holographic)
    {
        if(my_color == projectile.my_color && my_color != g_octarine 
        && (projectile.my_player != my_player || has_left_me(projectile)))
        {
            if(energy < 2 && !projectile.was_stopped)
            {
                with(projectile)
                {
                    move_bounce_all(false);
                    speed = max(0, speed-0.2);
                    //my_sound_play(wall_hum_sound);
                    my_sound_play_colored(wall_hum_sound, my_color);
                }
            }
            else
            {
                apply_force(projectile,true);
            }
        }
        else
        {
            if(projectile.my_player != my_player || my_player == gamemode_obj.environment)
            {
                receive_damage(projectile.force);
            }
        }
    }
}