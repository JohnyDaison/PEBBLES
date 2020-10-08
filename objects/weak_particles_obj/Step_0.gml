if(instance_exists(my_guy))
{
    x = my_guy.x;
    y = my_guy.y;
    
    if(active)
    {
        part_emitter_region(system,em,x - 20,x + 20,y - 23,y + 25,2,1);
        if(my_guy.step_count mod 5 == 0)
        {
            part_emitter_burst(system,em,pt,1);
        }
    }
}

/*
part_emitter_region(system,em,x - 28,x + 26,y - 33,y + 34,2,1);
part_emitter_burst(system,em,pt,14);
*/
