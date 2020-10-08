if(instance_exists(my_guy))
{
    x = my_guy.x;
    y = my_guy.y;
}

/*
part_emitter_region(system,em,x - 28,x + 26,y - 33,y + 34,2,1);
part_emitter_burst(system,em,pt,14);
*/

if(active)
{
    part_emitter_region(system,em,x - 12,x + 12,y - 23,y + 23,ps_shape_rectangle,ps_distr_gaussian);
    if(my_guy.step_count mod 8 == 0)
        part_emitter_burst(system,em,pt,1);
}

/* */
/*  */
