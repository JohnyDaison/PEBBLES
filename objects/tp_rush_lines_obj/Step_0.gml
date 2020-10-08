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
    var dir = irandom(360);
    part_type_direction(pt,dir, dir, 0, 0);
    
    part_emitter_region(system,em,x,x,y,y,ps_shape_rectangle,ps_distr_linear);
    if(my_guy.step_count mod 3 == 0)
        part_emitter_burst(system,em,pt,1);
}

/* */
/*  */
