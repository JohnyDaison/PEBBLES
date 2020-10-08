if(level_upgrade || level_setter)
{
    if(instance_exists(my_guy) && my_guy != id)
    {
        var count = ds_map_size(levels);
        var level = ds_map_find_first(levels);
        var has_set = 0, has_increased = 0;
        var popup_offset = 0;
        
        for(var i=0; i < count; i++)
        {
            var popup_str = DB.level_label[? level];
            var value = levels[? level];
            var old_val = my_guy.my_player.levels[? level];
            
            var success = false;
            if(level_upgrade)
            {
                success = level_increase(my_guy, level, value, level_upto);   
                if(success)  
                {
                    has_increased++;
                } 
            } 
            else if(level_setter)
            {
                success = level_set(my_guy, level, value);   
                if(success)  
                {
                    has_set++;
                }
            }
      
            if(success)
            {
                var level_val = my_guy.my_player.levels[? level];
                
                if(old_val <= 0 && level_val > 0)
                {
                    popup_str += " ACQUIRED!";
                }
                else if(old_val > 0 && level_val <= 0)
                {
                    popup_str += " REMOVED!";
                }
                else if(level_val > old_val)
                {
                    popup_str += " UPGRADED!";
                }
                else if(level_val < old_val)
                {
                    popup_str += " DOWNGRADED!";
                }
                
                switch(level)
                {
                    case "air_jump":
                    case "guy_orbit":
                        with(my_guy)
                        {
                            levels_inited = false;
                        }
                        break;
                    case "chargeball":
                        with(my_guy)
                        {
                            with(overhead_overlay)
                            {
                                if(my_guy == other.id)
                                {
                                    chborbit_blink_time = belts_blink_count*belt_blink_rate;
                                }
                            }
                            
                            if(!instance_exists(charge_ball))
                            {
                                var inst = instance_create(x,y,charge_ball_obj);
                                inst.my_guy = id;
                                inst.my_player = my_player;
                            
                                charge_ball = inst;
                            }
                        }
                        
                        break;
                    case "colors_belt_size":
                        with(my_guy)
                        {
                            with(overhead_overlay)
                            {
                                if(my_guy == other.id)
                                {
                                    belts_blink_time = belts_blink_count*belt_blink_rate;
                                }
                            }
                        
                            for(var col = g_red; col < g_blue; col++)
                            {
                                if(col == 3)
                                    col = g_blue;
                                
                                belt_size[? col] = level_val;  
                                var diff = level_val - old_val;                          
                                
                                // PULL ORBS FROM RESERVE
                                while(diff > 0 && orb_reserve[? col] >= 1)
                                {
                                    var orb = instance_create(x,y,color_orb_obj);
                                    orb.my_color = col;
                                    orb.tint_updated = false;
                                    orb.collected = true;
                                    orb.draw_label = false;
                                    orb.holographic = holographic;
                                    
                                    guy_belt_insert(orb.id, self.id);
                                    ds_list_add(orbs_in_use[? col], orb.id);
                                    
                                    orb_reserve[? col]--;
                                    diff--;
                                }
                            }
                        }
                        break;
                    case "black_belt_size":
                        with(my_guy)
                        {
                            with(overhead_overlay)
                            {
                                if(my_guy == other.id)
                                {
                                    belts_blink_time = belts_blink_count*belt_blink_rate;
                                }
                            }
                            
                            belt_size[? g_black] = level_val;
                        }
                        break;
                    case "inventory":
                        with(my_guy)
                        {
                            inventory_ready = false;
                        }
                        break;    
                    case "teleport":
                        with(my_guy)
                        {
                            if(abi_cooldown[? g_blue] > 1)
                            {
                                abi_cooldown[? g_blue] = 1;
                            }
                            teleport_uses_left = level_val;
                        }
                        break;
                }
                
                /*
                inst = instance_create(x,y-16+popup_offset,text_popup_obj);
                inst.str = popup_str;
                inst.my_color = my_color;
                inst.tint_updated = false;
                */
                
                popup_offset += 32;
            }
            
            level = ds_map_find_next(levels, level);
        }
        
        if(has_increased > 0 || has_set > 0)
        {
            effect_create_above(ef_firework,x,y,24,tint);
            my_sound_play(pickup_sound);
        }
    }
}

