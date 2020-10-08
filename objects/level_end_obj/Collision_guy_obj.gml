if(is_undefined(object_exit_step[? other.id]))
{
    object_exit_step[? other.id] = 0;
}

if(object_exit_step[? other.id] != -1 && (for_player == -1 || for_player == other.my_player.number))
{
    
    if(!preparing && !prepared && !was_prepared)
    {
        exit_anim_start = singleton_obj.step_count;
    }

    if(!prepared && !was_prepared)
    {
        object_exit_step[? other.id] = 0;

        if(!preparing)
        {
            preparing = true;   
        }
    }


    if(preparing)
    {
        prepare_anim_phase = singleton_obj.step_count - exit_anim_start;
    
        if(prepare_anim_phase >= exit_anim_prepare_time)
        {
            prepared = true;
            preparing = false;
        }
    
        // reset clean-up alarm
        alarm[1] = 2;
    }


    if(prepared)
    {    
        // start of exit animation
        if(object_exit_step[? other.id] == 0)
        {
            with(other)
            {
                self.orig_alpha = self.alpha;
                self.frozen_in_time = true;
                speed = 0;
            }
        }
    
        // fade out
        other.alpha = other.orig_alpha * (1-(object_exit_step[? other.id] / exit_anim_exit_time));
    
        // end of main part of exit animation
        if(object_exit_step[? other.id] >= exit_anim_exit_time)
        {
            with(other)
            {
                // human player
                if(my_player != gamemode_obj.environment)
                {
                    gamemode_obj.limit_reached = true;
                
                    if(gamemode_obj.winner == noone)
                    {
                        gamemode_obj.winner = my_player;
                    }
                
                    my_player.winner = true;
                    
                    my_sound_play(level_end_sound);
                }
            
                // guide
                if(my_player == gamemode_obj.environment)
                {
                    my_spawner.enabled = false;
                    instance_destroy();
                }
            }
        
            object_exit_step[? other.id] = -1;
        }
        else
        {
            //step
            object_exit_step[? other.id]++;
        }
    
        // reset clean-up alarm
        alarm[1] = 2;
    }
}