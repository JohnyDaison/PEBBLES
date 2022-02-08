if(instance_exists(my_guy))
{
    x = my_guy.x;
    y = my_guy.y;
}

if(active)
{
    part_type_direction(pt,my_guy.direction, my_guy.direction, 0, 0);
    part_type_speed(pt, my_guy.speed, my_guy.speed, 0, 0);
    
    part_emitter_region(system, em, x - 12, x + 12, y - 35, y - 25, ps_shape_ellipse, ps_distr_invgaussian);
    if (my_guy.step_count mod 3 == 0)
        part_emitter_burst(system, em, pt, 1);
}
