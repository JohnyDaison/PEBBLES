if(!lost_control && !other.collected && holographic == other.holographic
&& (other.for_player == -1 || other.for_player == my_player.number))
{
    var picked_count = 0;
    var item_index = other.object_index;
    var item = other.id;

    if(item.consumed_on_pickup)
    {
        item.my_guy = id;
        
        var new_tech = false;
        if(item.level_upto)
        {
            var tech = ds_map_find_first(item.levels);
            
            while(!is_undefined(tech))
            {
                if(!has_level(id, tech, item.levels[? tech]))
                {
                    new_tech = true;
                }
                
                tech = ds_map_find_next(item.levels, tech);
            }
        }
        else if(item.level_upgrade)
        {
            var tech = ds_map_find_first(item.levels);
            
            while(!is_undefined(tech))
            {
                if(!has_level(id, tech, 1))
                {
                    new_tech = true;
                }
                
                tech = ds_map_find_next(item.levels, tech);
            }
        }
        else
        {
            new_tech = true;
        }
        
        var overlay;
        var show_desc =
            gamemode_obj.object_index == campaign_obj
            && instance_exists(my_player.my_camera)
            && item.object_index != SECRET_obj
            && item.object_index != qubit_obj
            && new_tech;
            
        // currently only the level_upgrade items use this event
        // TODO: this should work in general, but only the first time you get that type of item
        
        if(show_desc)
        {
            overlay = add_player_overlay(item_description_overlay, my_player);
        }
        
        with(item)
        {
            if(show_desc)
            {
                overlay.image = sprite_index;
                overlay.title = name;
                if(description_name != "")
                {
                    overlay.title = description_name;
                }
                overlay.item_color = tint;
                if(colour_get_value(tint) > 250)
                {
                    overlay.outline_color = c_dkgray;
                }
                overlay.message = description;
            }
            
            picked_count = stack_size;
            
            var params = ds_map_create();
            params[? "who"] = other.id;
            params[? "picked_count"] = picked_count;
            register_ds("params", ds_type_map, params, id);
            
            broadcast_event("item_pickup", id, params);   
            
            event_perform(ev_other, ev_user1);
            
            instance_destroy();
        }
    }
    else
    {
        picked_count = add_to_inventory(item, true);
        
        if(picked_count > 0)
        {
            with(item)
            {
                var params = ds_map_create();
                params[? "who"] = other.id;
                params[? "picked_count"] = picked_count;
                register_ds("params", ds_type_map, params, id);
            
                broadcast_event("item_pickup", id, params);    
            }
            
            add_to_inventory(item);
        }
    }
}

