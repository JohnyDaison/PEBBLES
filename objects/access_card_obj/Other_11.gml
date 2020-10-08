var terminal = instance_nearest(my_guy.x, my_guy.y, access_terminal_obj);

if(distance_to_object(terminal) > 32)
{
    terminal = noone;
}

if(instance_exists(terminal) && terminal.ready)
{
    with(my_guy)
    {
        take_from_inventory(other);
    }
    
    draw_label = false;
    
    placed = true;
    used = true;
    sticky = true;
    attached = true;
    
    stuck_to = terminal;
    stuck_x = 0;
    stuck_y = slide_in_start;
    depth = terminal.depth + 1;
    
    terminal.ready = false;
    terminal.active = true;
}