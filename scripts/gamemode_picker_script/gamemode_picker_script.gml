function gamemode_picker_script() {
    var gm_pane = play_menu_window.gamemode_pane;
    var gm = DB.gamemodes[? gm_pane.gamemode_picker.cur_item_id], i, count, place;

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
    }

    mods_controls_update();

    schedule_play_summary_update();
}
