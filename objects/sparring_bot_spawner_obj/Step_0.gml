/// @description UPDATE DEAD GUY
event_inherited();

if(instance_exists(my_guy))
{
    if(my_guy.dead)
    {
        if(!guy_was_dead)
        {
            if(difficulty_level < max_difficulty_level)
            {
                difficulty_level++;
                instance_destroy(my_guy);
                alarm[2] = 90;
            }
            else
            { 
                instance_destroy();
                with(level_end_obj)
                {
                    for_player = 1;   
                }
                with(player_obj)
                {
                    if(self.id != gamemode_obj.environment)
                    {
                        winner = true;
                    }
                }
                gamemode_obj.limit_reached = true;
                
                exit;
            }
        }
        
        guy_was_dead = true;   
    }
    else
    {
        guy_was_dead = false;
    }
    
}
