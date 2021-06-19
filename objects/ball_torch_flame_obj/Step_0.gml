if(instance_exists(my_guy))
{
    x = my_guy.x;
    y = my_guy.y;
    
    part_type_color1(pt, my_guy.tint);
}

if(active)
{
    part_emitter_region(system, em, x - radius, x + radius, y - radius, y + radius,
                        ps_shape_ellipse, ps_distr_gaussian);
    part_emitter_burst(system, em, pt, 4);
}
