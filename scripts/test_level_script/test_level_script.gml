function test_level_script() {
    tool_reset_onup();

    if(instance_number(editor_guy_spawner_obj) > 0)
    {
        with(selection_obj)
        {
            instance_destroy();
        }
    
        with(grid_drawer)
        {
            instance_destroy();
        }
    
        editor_camera.on = false;
    
        var req_gamepad1 = main_editor_toolbar.gamepad1_checkbox.checked;
        var req_gamepad2 = main_editor_toolbar.gamepad2_checkbox.checked;
    
        show_debug_message("pads: "+string(req_gamepad1)+""+string(req_gamepad2));
    
        with(empty_toolbar)
        {
            instance_destroy();
        }
    
        with(empty_window)
        {
            instance_destroy();
        }
    
        with(editor_terrain_obj)
        {
            terrain_grid_remove();
            visible = false;
        }
    
        DB.player_num = 0;
        total_players = 0;
    
        instance_create(0,0,gamemode_obj);
    
        gamemode_obj.arena_name = place_obj.name;
        for(i=0;i<DB.limit_count;i+=1)
        {
            var limit_name = DB.limit_ids[| i];
            gamemode_obj.limit_active[? limit_name] = false;
        }
    
        with(editor_guy_spawner_obj)
        {
            player = instance_create(0,0,player_obj);
            player.number = player_number;
            player.name = "Player "+string(player_number);
            show_debug_message("plnum: "+string(player_number));
            if(player_number == 1)
            {
                if(req_gamepad1)
                {
                    player.control_set = gamepad;
                    player.control_index = 1;
                }
                else
                {
                    player.control_set = keyboard1;
                }
            }
            if(player_number == 2)
            {
                if(req_gamepad2)
                {
                    player.control_set = gamepad;
                    player.control_index = 2;
                }
                else
                {
                    if(req_gamepad1)
                    {
                        player.control_set = keyboard1;    
                    }
                    else
                    {
                        player.control_set = keyboard2;
                    }
                }
            }
        
            //player.control_set = player_number;
            ds_map_add(gamemode_obj.players,player_number,player);
            visible = false;
            other.total_players += 1;
        }
        gamemode_obj.player_count = total_players;
    
        show_debug_message("Environment exists? "+string(ds_map_exists(gamemode_obj.players,0)));
    
        //total_players = ds_map_size(gamemode_obj.players);
        //gamemode_obj.player_count = total_players;
        show_debug_message("player_count: "+string(gamemode_obj.player_count));
        instance_create(round(place_obj.x + place_obj.width/2), round(place_obj.y + place_obj.height/2), main_camera_obj);
    
        with(editor_terrain_obj)
        {
            if(palette_index == 1)
            {
                instance_create(x,y,perma_wall_obj);
            }
            if(palette_index == 2)
            {
                instance_create(x,y,wall_obj);
            }
        }
    
        done = false;
        current_player = 1;
    
        while(!done)
        {
            with(editor_guy_spawner_obj)
            {
                if(player_number == other.current_player)
                {
                    instance_create(x,y,guy_spawner_obj);
                    other.current_player += 1;
                }
            }
            if(other.current_player > other.total_players)
            {
                other.done = true;
            }
        }
    
        instance_create(0,0,pickup_spawner_obj);
    
        with(editor_jump_pad_obj)
        {
            i = instance_create(x+16,y+24,jump_pad_obj);
            i.max_power = max_power;
            visible = false;
        }
    
        with(editor_turret_obj)
        {
            i = instance_create(x,y,turret_mount_obj);
            i.direction = direction;
            visible = false;
        }
    
        cursor_obj.tooltip = "";
    
        with(gamemode_obj)
        {
            event_perform(ev_other,ev_room_start);
        }
    }
}
