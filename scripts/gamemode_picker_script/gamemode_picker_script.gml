function gamemode_picker_script() {
    var play_window = play_menu_window;
    var gm = DB.gamemodes[? play_window.gamemode_picker.cur_item_id];

    if (!is_undefined(gm)) {
        // GAMEMODE PANE
        with(play_window)
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
            
                // POPULATE place_picker
                ds_list_clear(place_names);
                ds_list_clear(place_ids);
            
                var place_count = play_menu_window.world.place_count;
            
                for (var i = 0; i < place_count; i++) {
                    var place = play_menu_window.world.places[| i];
                    place_names[| i] = place.name;
                    place_ids[| i] = place.room_id;
                }
            
                gui_list_picker_items_reset(place_picker, "text", place_names, place_ids);
                
                // POPULATE preset_dropdown
                ds_list_clear(preset_names);
                ds_list_clear(preset_ids);
                
                var preset_list = gm[? "rule_presets"];
                var preset_count = ds_list_size(preset_list);

                for (var i = 0; i < preset_count; i++) {
                    var preset = DB.rule_presets.find_preset_by_id(preset_list[| i]);
                    
                    if (is_undefined(preset)) {
                        my_console_log("!!! PRESET NOT FOUND: " + string(preset_list[| i]));
                        continue;
                    }
                    
                    ds_list_add(preset_names, preset.name);
                    ds_list_add(preset_ids, preset.str_id);
                }
                
                gui_list_picker_items_reset(preset_dropdown.list_picker, "text", preset_names, preset_ids);
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
    }

    rules_controls_update();

    schedule_play_summary_update();
}
