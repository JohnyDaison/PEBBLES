function gamemode_picker_script() {
	var gm_pane = play_menu_window.gamemode_pane;
	var players_pane = play_menu_window.players_pane;
	var player_panes_map = play_menu_window.player_panes_map;

	var gm = DB.gamemodes[? gm_pane.gamemode_picker.cur_item_id], i, count, place, pl_num;

	if(!is_undefined(gm))
	{
	    // GAMEMODE PANE
	    with(gm_pane)
	    {
	        // UPDATE WORLD
	        if(play_menu_window.world == noone || play_menu_window.world.object_index != gm[? "world"])
	        {
	            if(instance_exists(play_menu_window.world))
	            {
	                instance_destroy(play_menu_window.world);
	            }
            
	            play_menu_window.world = instance_create(0,0, gm[? "world"]);
            
	            //world_name_label.text = play_menu_window.world.name;
            
	            ds_list_clear(place_names);
	            ds_list_clear(place_ids);
            
	            count = play_menu_window.world.place_count;
            
	            for(i=0; i< count; i++)
	            {
	                place = play_menu_window.world.places[| i];
	                place_names[| i] = place.name;
	                place_ids[| i] = place.room_id;
	            }
            
	            gui_list_picker_items_reset(place_picker, "text", place_names, place_ids);
	        }
        
	        // UPDATE PLACES
	        if(instance_exists(play_menu_window.world) && instance_exists(place_picker.scroll_list))
	        {
	            with(place_picker)
	            {
	                var last_cur_item = scroll_list.cur_item;
	                scroll_list.cur_item = ds_list_find_index(id_list, gm[? "start_place_room"]);
	                scroll_list.selection_pos += (scroll_list.cur_item - last_cur_item);
	                with(scroll_list)
	                {
	                    script_execute(item_change_script);
	                }
	            }
	        }
        
        
	    }
    
	    // PLAYERS PANE
	    with(players_pane)
	    {
	        // UPDATE PLAYER NUMBER
	        playernum_input.min_value = gm[? "min_players"];
	        playernum_input.max_value = gm[? "max_players"];
	    }
    
	    // PLAYER PANES
	    for(pl_num = 1; pl_num <= players_pane.player_pane_count; pl_num++)
	    {
	        var pane = player_panes_map[? pl_num];
        
	        with(pane)
	        {
	            // UPDATE CONTROL DROPDOWN LISTS
	            if(instance_exists(control_dropdown.list_picker))
	            {
	                ds_list_clear(controls_names);
	                ds_list_clear(controls_ids);
                
	                var count = ds_list_size(DB.control_set_order), i, control_id, name;
                
	                for(i = 0; i < count; i++)
	                {
	                    control_id = DB.control_set_order[| i];
                    
	                    if(control_id == cpu_control_set && pl_num <= gm[? "min_real_players"])
	                    {
	                        continue;
	                    }
                    
	                    name = DB.control_set_names[| control_id];
                    
	                    ds_list_add(controls_names, name);
	                    ds_list_add(controls_ids, control_id);
	                }
                
	                gui_list_picker_items_reset(control_dropdown.list_picker, "text", controls_names, controls_ids);
                
	                // select gamepad as default if CPU is not available
	                /*
	                if(controls_ids[| 0] != cpu_control_set)
	                {
                       
	                }
	                */
	            }
	        }
	    }
    
	}

	mods_controls_update();

	play_summary_update();



}
