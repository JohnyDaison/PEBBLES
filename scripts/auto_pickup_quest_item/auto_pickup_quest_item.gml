function auto_pickup_quest_item(player, quest_node) {
    var item_found = false;
    var item_index = quest_node[? "target_item"];
    var item_i, item, registered_count = place_controller_obj.item_list_size;
    var guy = player.my_guy;
    
    if(!instance_exists(guy)) {
        return false;
    }
    
    //show_debug_message("item_pickup, color: " + string(quest_node[? "target_color"]));
                                
    with(item_index)
    {
        if(for_player == player.number && (quest_node[? "target_color"] == -1 || quest_node[? "target_color"] == my_color))
        {
            x = guy.x;
            y = guy.y;
                                        
            item_found = true;
                                        
            /*
            my_console_log("MOVED ITEM TO ME 1: " + object_get_name(item_index));
                                        
            with(other)
            {
                speech_instant("MOVED ITEM TO ME 1: " + object_get_name(item_index));   
            }
            */
        }
    }
                                
    if(!item_found)
    {
        for(item_i = 0; item_i < registered_count; item_i++)
        {
            item = place_controller_obj.item_list[| item_i];
            var index_str = "";
                                    
            if( item.object_index != item_index && 
                !( item.object_index == data_holder_obj && item.transform_memory[? "object_index"] == item_index ))
            {
                continue;
            }
                                    
            with(item)
            {
                if(for_player == player.number && (quest_node[? "target_color"] == -1 || quest_node[? "target_color"] == my_color))
                {
                    x = guy.x;
                    y = guy.y;
                                        
                    item_found = true;
                                                
                    index_str = object_get_name(item.object_index);
                                                
                    if(item.object_index == data_holder_obj)
                    {
                        index_str = object_get_name(item.transform_memory[? "object_index"]);
                                                    
                        chunk_deregister(chunkgrid_obj, item);
                    }
                    /*
                    my_console_log("MOVED ITEM TO ME 2: " + index_str);
                                                
                    with(other)
                    {
                        speech_instant("MOVED ITEM TO ME 2: " + index_str);
                    }
                    */
                }
            }
        }
    }
    
    return item_found;
}