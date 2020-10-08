/// @description  FOLLOW GUY
if(instance_exists(my_guy))
{
    x = my_guy.x;
    y = my_guy.y;
    invisible = my_guy.invisible || !active;
    visible = !invisible;
    if(part_system_exists(system))
        part_system_automatic_draw(system, !invisible);
}

