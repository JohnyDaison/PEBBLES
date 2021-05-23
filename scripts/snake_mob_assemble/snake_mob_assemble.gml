/// @description snake_mob_assemble([max_gain]);
/// @function snake_mob_assemble
/// @param [max_gain]
function snake_mob_assemble() {
    var max_gain = -1;
    var count = 0, wall;

    if(argument_count >= 1)
    {
        max_gain = argument[0];   
    }
    if(argument_count >= 2)
    {
        count = argument[1];   
    }
    var i;

    if(max_gain == 0)
    {
        return count;
    }

    group_add_member(ter_group, cur_ter);
    cur_ter.moving = true;
    cur_ter.energy = max(0.25, cur_ter.energy);
    if(cur_ter.my_color == g_dark)
        cur_ter.my_next_color = body_col;
    x = cur_ter.x;
    y = cur_ter.y;

    body_size = ds_list_size(ter_group.members);
    
    for(i=0; i<4; i++)
    {
        wall = cur_ter.near_walls[? i];

        if(instance_exists(wall) && wall.cover != cover_indestr
        && !wall.moving && !wall.falling
        && ds_list_find_index(ter_group.members, wall) == -1)
        {
            cur_ter = wall;
        
            if(max_gain > -1)
            {
                max_gain -= 1;
            }
            count++;
        
            return snake_mob_assemble(max_gain, count);
        }
    }
}
