/// @description use_inv_item(index)
/// @function use_inv_item
/// @param index
function use_inv_item(argument0) {
	var index = argument0;
	if(index > 0)
	{
	    index = floor(index);
	    var item = self.inventory[?index], used_item;
	    if(instance_exists(item) && object_is_ancestor(item.object_index, item_obj))
	    {
	        if(item.usable && item.stack_size > 0 && item.use_cooldown_left == 0)
	        {
	            inv_curr_index = index;
	            if(item.activatable)
	            { 
	                with(item)
	                {
	                    event_perform(ev_other, ev_user1);
	                    if(holdable)
	                    {
	                        item_hold_mode(index);
	                    }
	                    else
	                    {
	                        item.use_cooldown_left = item.use_cooldown_length;
	                    }
	                }
	            }
	            else
	            {
	                if(item.consumable)
	                {
	                    used_item = take_from_inventory(item, 1);
	                }
	                else
	                {
	                    used_item = item;       
	                }

                
	                with(used_item)
	                {
	                    event_perform(ev_other, ev_user1);
	                    if(holdable)
	                    {
	                        item_hold_mode(index);
	                    }
	                    else
	                    {
	                        if(instance_exists(item))
	                        {
	                            item.use_cooldown_left = item.use_cooldown_length;
	                        }
                        
	                        if(destroy_on_use && used)
	                        {
	                            instance_destroy();
	                        }
	                    }
	                }
	                increase_stat(my_player, "total_items_used", 1, false);
	            }
	        }
	        else
	        {
	            full_inv_blink = true;
	        }
	    }
	}




}
