if(instance_exists(my_guy))
{
    x = my_guy.x;
    y = my_guy.y;
    if(my_guy.channeling)
        part_type_colour1(pt, my_guy.channel_tint);
    if(my_guy.has_tp_rush)
        part_type_colour1(pt, DB.colormap[? g_blue]);
        
    if(active)
    {
        part_emitter_region(system, em, x - radius, x + radius, y - radius, y + radius, ps_shape_ellipse, ps_distr_gaussian);
        part_emitter_burst(system, em, pt, round(max_pt * min(1, my_guy.channel_duration/my_guy.channel_duration_threshold)));
    }
}
