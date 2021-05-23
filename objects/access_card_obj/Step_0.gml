/// @description SLIDE IN

event_inherited();

if(stuck_to != noone && energy > 0)
{
    var terminal = stuck_to;
    
    if(terminal.my_color != my_color)
    {
        if(stuck_y > slide_in_end)
        {
            stuck_y -= slide_in_speed;    
        }
        else
        {
            terminal.my_color = my_color;
            terminal.tint_updated = false;
            terminal.energy += energy;
                        
            energy = 0;
            my_color = g_dark;
            tint_updated = false;
            
            my_sound_play(gate_on_sound);
            
            alarm[9] = inside_terminal_time;
    
            /*
            with(gate_obj)
            {
                if(point_distance(x,y, terminal.x, terminal.y) < terminal.range)
                {
                    my_block.my_next_color = terminal.my_color;      
                }
            }   
            */
        }
    }
}
