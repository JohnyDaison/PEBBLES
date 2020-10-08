if(surface_exists(singleton_obj.paused_surface))
{
    draw_set_alpha(1);
    draw_surface_stretched(singleton_obj.paused_surface,0,0, view_wport[0], view_hport[0]);
}

event_inherited();
