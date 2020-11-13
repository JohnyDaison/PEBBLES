if(instance_exists(my_block) && singleton_obj.step_count > 5 && singleton_obj.step_count % 10 == 0) {
    if (my_block.my_color > g_black && my_block.my_color < g_octarine) {
        my_color = my_block.my_color;
        tint_updated = false;
    }
    
    if(my_color == g_black) {
        exit;
    }
    
    var chosen_wall = noone, valid_wall = noone;
    
    for(var dir = right; dir <= down; dir++) {
        var wall = my_block.near_walls[? dir];
        
        if(!instance_exists(wall) || (!spread_to_dark && wall.my_color == g_black)) {
            continue;
        }
        
        if(ds_list_find_index(previous_blocks, wall) == -1) {
            chosen_wall = wall;
        }
        
        valid_wall = wall;
        
        if(instance_exists(chosen_wall) && chosen_wall.my_color != my_color) {
            break;
        }
    }
    
    if(chosen_wall == noone && valid_wall != noone) {
        chosen_wall = valid_wall;
    }
    
    if(instance_exists(chosen_wall)) {
        ds_list_add(previous_blocks, my_block);
        my_block = chosen_wall;
        x = my_block.x + 15;
        y = my_block.y + 15;
        
        if(ds_list_size(previous_blocks) > previous_count) {
            ds_list_delete(previous_blocks, 0);
        }
    }
    
    my_block.my_next_color = my_color;
    if (my_block.energy == 0) {
        my_block.energy = 0.1;
    }
}