/// @description gui_reset_scroll_items(scroll_list, type, [source_list])
/// @function gui_reset_scroll_items
/// @param scroll_list
/// @param type
/// @param [source_list]
function gui_reset_scroll_items() {
	var scroll_list = argument[0];
	var type = argument[1];
	var source_list = noone;

	if(argument_count > 2)
	{
	    source_list = argument[2];
	}

	if(instance_exists(scroll_list))
	{
	    with(scroll_list)
	    {
	        ds_list_clear(items);
    
	        if(ds_exists(source_list, ds_type_list))
	        {
	            if(type == "text")
	            {
	                ds_list_copy(items, source_list);
	                id.type = "text";
	            }
	            else if(type == "flag")
	            {
	                var i, count = ds_list_size(source_list);

	                for(i=0; i < count; i++)
	                {
	                    id.items[| i] = DB.bf_icon_map[? (source_list[| i])];
	                }
        
	                id.type = "icon";
	            }
	        }
    
	        item_count = ds_list_size(items);
	        if(item_count == 0)
	        {
	            cur_item = -1;
	        }
	        else
	        {
	            cur_item = 0;
	            selection_pos = 0;
	        }
    
	        first_item = max(0, min(item_count - max_items, cur_item - selection_pos));
	        last_item = min(item_count-1, first_item + max_items-1);
	    }
	}



}
