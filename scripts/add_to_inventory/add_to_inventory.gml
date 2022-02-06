/// @description add_to_inventory(pickup)
/// @function add_to_inventory
/// @param pickup
/// @param [only_count]
function add_to_inventory() {
    var pickup = argument[0];
    var only_count = false;
    if(argument_count > 1)
    {
        only_count = argument[1];   
    }

    var i, item, item_count = 0, free_slot = -1;
    var got_one = false;
    var stacking = false;

    var added = 0, stack_left = 0, stack_part;

    if(instance_exists(pickup))
    {
        if(!pickup.collected && !pickup.used && holographic == pickup.holographic && pickup.newly_dropped_guy != id)
        {
            var special_case = false;
        
            // CONSUMING CRYSTALS
            if(pickup.object_index == crystal_obj)
            {
                if(crystal_will_be_consumed())
                {
                    added = pickup.stack_size;
                
                    if(!only_count)
                    {
                        guy_consume_shard(pickup);
                    }
                
                    special_case = true;               
                }
            }
        
            // NORMAL PICKUP
            if(!special_case)
            {
                // HANDLE RESERVATIONS
                reserved_slot = 0;
                for(var i=1; i <= inventory_size; i++)
                {
                    if(pickup.object_index == inv_reserved[?i])
                    {
                        reserved_slot = i;
                    }       
                }
            
                if(reserved_slot == 0)
                {
                    var start_item = 1;
                    var end_item = inventory_size;  
                }
                else
                {
                    var start_item = reserved_slot;
                    var end_item = reserved_slot;  
                }
            
                // STACK OR ASSIGN SLOT
                stack_left = pickup.stack_size;
            
                for(i = start_item; i <= end_item; i++)
                {
                    item = inventory[? i];
                
                    if(instance_exists( item ) )
                    {
                        item_count++;
                    
                        if(item.object_index == pickup.object_index && item.name == pickup.name)
                        {
                            got_one = true;
                        
                            if(item.stack_size < item.max_stack_size && item.my_color == pickup.my_color)
                            {
                                stacking = true;
                                stack_part = min(item.max_stack_size - item.stack_size, stack_left);
                            
                                if(!only_count)
                                {
                                    if(item.stack_size == 0)
                                    {
                                        item.newly_got_steps = item.newly_got_anim_duration;   
                                    }
                                
                                    item.stack_size += stack_part;
                                    pickup.stack_size -= stack_part;
                                }
                            
                                stack_left -= stack_part;
                            
                                added += stack_part;
                            
                            }
                        }
                    }
                    else if(free_slot = -1
                    && (inv_reserved[?i] == noone || inv_reserved[?i] == pickup.object_index))
                    {
                        free_slot = i;   
                    }
                }
            
            
                if((free_slot != -1 || stacking) && !(pickup.unique && got_one))
                {
                    // PICKUP EFFECT
                    if(!pickup.reserved && !only_count)
                    {
                        effect_create_above(ef_firework,pickup.x,pickup.y,48,pickup.tint);
                
                        my_sound_play(pickup.pickup_sound);
                    
                        if(pickup.pickup_show_name)   
                        { 
                            i = instance_create(pickup.x, pickup.y-16, text_popup_obj);
                            i.str = pickup.name;
                            i.my_color = pickup.my_color;
                            i.tint_updated = false;
                        }
                    
                        pickup.newly_got_steps = pickup.newly_got_anim_duration;
                    }
                
                
                    if(!stacking)
                    {
                        // NEW ITEM TO FREE SLOT
                        if(!only_count)
                        {
                            pickup.my_guy = id;
                            inventory[? free_slot] = pickup.id;
                            pickup.inv_index = free_slot;
                            inv_curr_index = free_slot;
                            pickup.visible = false;
                            pickup.collected = true;
                            pickup.alarm[0] = -1;
                            pickup.step = 0;
                            pickup.light_yoffset = 0;
                            pickup.hover_offset = 0;
                            pickup.my_player = my_player;
                            pickup.fresh = false;
                            if(instance_exists(pickup_spawner_obj))
                            {
                                pickup_spawner_obj.spawned_item_count -= pickup.stack_size;
                            }
                        }
                        
                        added = pickup.stack_size;
                    }
                    else
                    {
                        // STACKED, DESTROY PICKUP
                        if(pickup.stack_size <= 0)
                        {
                            with(pickup)
                            {
                                instance_destroy();
                            }
                        }
                    }
                }
                else
                {
                    // "INVENTORY FULL" EFFECT
                    full_inv_blink = true;
                }
            }
        
            if(added > 0)
            {
                last_added_item_step = step_count;
            }
        }
    }

    return added;



}
