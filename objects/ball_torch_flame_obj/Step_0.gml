if(instance_exists(my_guy))
{
    x = my_guy.x;
    y = my_guy.y;
    
    part_type_color1(pt, my_guy.tint);
    
    var energy_ratio = max(0.2, my_guy.energy / my_guy.max_energy);
    
    part_type_size(pt, energy_ratio * 0.7, energy_ratio * 0.7, -0.03,0);
    part_type_life(pt, energy_ratio * 10, energy_ratio * 25);
    part_type_speed(pt, energy_ratio * 5, energy_ratio * 5, -0.2, 0.2);
}

if(active)
{
    part_emitter_region(system, em, x - radius, x + radius, y - radius, y + radius,
                        ps_shape_ellipse, ps_distr_gaussian);
    part_emitter_burst(system, em, pt, 4);
}
