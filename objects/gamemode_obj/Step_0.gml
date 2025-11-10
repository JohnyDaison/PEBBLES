// TODO: revive this effect but make it apply to individual player views
/*
if(pixelating_left > 0)
{
    time_ratio = (1-(pixelating_left-1)/pixelate_time);
    cur_step = ceil(pixelate_steps*time_ratio);
    cur_ratio = power(2,cur_step);
    
    if(cur_step < pixelate_steps)
    {
        surface_resize(application_surface, cur_ratio*pixels_x, cur_ratio*pixels_y); 
        pixelating_left -= 1;
    }
    else 
    {
        surface_resize(application_surface, display_get_gui_width(), display_get_gui_height()); 
        pixelating_left = 0;
    }
}
*/
