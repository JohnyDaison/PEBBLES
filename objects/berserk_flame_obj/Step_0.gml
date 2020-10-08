if(instance_exists(my_guy))
{
    x = my_guy.x;
    y = my_guy.y;
}
if(active)
{
    part_emitter_region(system,em,x - 6,x + 6,y - 23,y + 25,2,1);
    part_emitter_burst(system,em,pt,5);
}

