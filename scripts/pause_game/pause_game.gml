function pause_game() {
	singleton_obj.paused = true;
	singleton_obj.paused_room = room;
	singleton_obj.paused_surface = surface_create(singleton_obj.current_width, singleton_obj.current_height);

	// debug
	/*
	with(camera_obj)
	{
	    var id_str = "";
    
	    if(object_index == main_camera_obj)
	    {
	        id_str = "main"
	    }
	    else
	    {
	        id_str = string(my_player.number);
	    }
    
	    if(surface_exists(view_surface))
	    {
	        surface_save(view_surface, "camera_" + id_str + ".png");   
	    }
	}
	*/

	surface_set_target(singleton_obj.paused_surface);

	// clear surface with black ?
	/*
	draw_set_color(c_black);
	draw_set_alpha(1);
	draw_set_blend_mode(bm_normal);
	draw_rectangle(0,0, singleton_obj.current_width, singleton_obj.current_height, false);
	*/
	//surface_save(singleton_obj.paused_surface, "paused_cleared.png");

	// draw player displays
	with(player_display_obj)
	{
	    event_perform(ev_draw, ev_gui);
	}

	// debug
	//surface_save(singleton_obj.paused_surface, "paused.png");

	// finish
	surface_reset_target();

	/*
	with(gamemode_obj) {
	    ds_list_add(singleton_obj.were_persistent, id);
	    persistent = false;
	}

	with(player_obj) {
	    ds_list_add(singleton_obj.were_persistent, id);
	    persistent = false;
	}
	*/

	room_persistent = true;
	room_goto(pausemenu);



}
