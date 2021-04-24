/// @description INTRODUCTION
event_inherited();

// INTRODUCTION
if(!introduction_finished)
{
    with(player_obj)
    {
        if(self.id != gamemode_obj.environment && instance_exists(my_guy))
        {
            // DON'T MOVE
            my_guy.locked = true;
            
            // KEEP TIMER AT 00:00
            with(timer_window) {
                raw_total = 0;
            }
        }
    }
    
    // INTRO ENDS WHEN GUIDE SPEAKS
    if(instance_exists(my_guy) && my_guy.speaking)
    {
        introduction_finished = true;
    }
}
