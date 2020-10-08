// behavior
if(instance_exists(my_spawner))
{
    my_guy = my_player.my_guy;
    if(my_spawner.enabled && my_spawner.object_index == guy_spawner_obj)
    {
        // AFTERSPAWN PROTECTION 
        if(self.activated && instance_exists(my_guy) && !my_guy.dead)
        {
            my_guy.locked = true;
            my_guy.protected = true;
            my_guy.gravity = 0;
            my_guy.x = x;
            my_guy.y = y;
            my_guy.speed = 0;
            my_guy.alarm[2] = my_spawner.protection_time;
        
            if(my_guy.wanna_run || my_guy.wanna_jump)
            {
                self.activated = false;
                my_spawner.activated = false;
            }
        }
    }
}

// rift size and seconds left
hor_size = 1;
seconds_left = 0;

if(activated)
{
    if(instance_exists(my_guy))
    {
        if(my_guy.alarm[5] > 0 && my_guy.current_respawn_time > 0)
        {
            hor_size = 1 - (my_guy.alarm[5] / my_guy.current_respawn_time);
            //hor_size *= 1.2;
        }
    
        seconds_left = ceil(my_guy.alarm[5] / singleton_obj.game_speed);
    
        respawning = my_guy.dead;
        
        if(!respawning && !my_guy.locked)
        {
            activated = false;   
        }
    }
}

// portal rotation and pulsing
angle += 5;
angle = angle mod 360;
scale = 0.9 + sin(degtorad(angle)) * 0.2;

if(activated)
{
    alpha = 1;
}
else if(alpha > 0)
{
    alpha = max(0, alpha - alpha_decay);
}