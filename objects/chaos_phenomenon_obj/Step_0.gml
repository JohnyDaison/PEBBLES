if(singleton_obj.step_count > 5 && singleton_obj.step_count % 10 == 5) {
    ds_list_clear(block_list);

    with(wall_obj) {
        if(my_color > g_black && my_color < g_octarine) {
            ds_list_add(other.block_list, id);
        }
    }
    
    var index = irandom(ds_list_size(block_list) - 1);
    var block = block_list[| index];
    
    block.my_next_color = irandom_range(g_red, g_white);
}