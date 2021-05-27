event_inherited();

if(false) // enable_focus_shift
{
    if(DB.gui_controls[# up,free] && DB.gui_controls[# down,free] && DB.gui_controls[# left,free] && DB.gui_controls[# right,free])
    {
        step_count = 0;
        right_step = true;
    }
    else
    {
        right_step = (step_count mod round(repeat_rate) == 0);
        if(right_step)
        {
            step_count = 0;
        }
    }
    
    if(DB.gui_controls[# stepmode,free])
    {
        shifted = false;
    }
    /*
    show_debug_message("--------------------");
    
    show_debug_message("GUI UP: "+string(DB.gui_controls[# up,held]));
    */
    
    for(cur_dir=0;cur_dir<4;cur_dir+=1)
    {
        if(!shifted)
        {
            if(DB.gui_controls[# cur_dir,held])
            {
                if(right_step && (step_count == 0 || step_count > repeat_wait))
                {
                    show_debug_message("-- SHIFTING GUI FOCUS -- "+string(cur_dir));
                    gui_focus_shift(cur_dir);
                    shifted = true;
                    DB.mouse_has_moved = false;
                }
                step_count += 1;
            }
        }
    }
}
