function match_start() {
	/*
	matchwindow = match_setup_window.id;
	gui_list = matchwindow.gui_content;

	pane = matchwindow.players_pane;

	if(pane.player_num >= pane.min_player_num)
	{
	    DB.player_num = 0;
	    match = instance_create(0,0,match_obj);
    
	    // players
	    for(i=0;i<4;i+=1)
	    {
	        if(pane.number_labels[i].text != pane.number_labels[i].orig_text)
	        {
	            new_player = instance_create(0,0,player_obj);
	            new_player.number = real(pane.number_labels[i].text);
	            /*
	            switch(new_player.number)
	            {
	                case 1: new_player.icon = icon_1_spr; break;
	                case 2: new_player.icon = icon_2_spr; break;
	                case 3: new_player.icon = icon_3_spr; break;
	                case 4: new_player.icon = icon_4_spr; break;
	            }
	            */
	            /*
	            new_player.flag = "number" + string(new_player.number) + "_flag";
	            new_player.icon = DB.bf_icon_map[? new_player.flag];
	            new_player.name = pane.player_names[i].text;
            
	            var ctrl_set = (pane.control_dropdowns[i]).value;
            
	            if(ctrl_set == cpu_control_set)
	            {
	                new_player.is_cpu = true;
	                new_player.cpu_difficulty = 1;
	            }
	            else
	            {
	                new_player.control_set = ctrl_set;
	                new_player.control_index = i;
	            }
	            ds_map_add(match.players,new_player.number,new_player.id);
	            match.player_count = new_player.number;
	        }
	    }
	    ds_list_copy(DB.player_names,pane.player_picker.scroll_list.items);
    
	    // limits
	    pane = matchwindow.limits_pane;
    
	    for(i=0;i<DB.limit_count;i+=1)
	    {
	        limit_name = DB.limit_ids[| i];
	        limit_checkbox = pane.limit_checkboxes[i];
	        limit_dial = pane.limit_dials[i];
	        if(limit_checkbox.checked)
	        {
	            match.limit_active[? limit_name] = true;
	            match.limits[? limit_name] = limit_dial.value;
	        }
	        else
	        {
	            match.limit_active[? limit_name] = false;
	        }
	    }
   
	    // match
	    pane = matchwindow.match_pane;
     
	    //match.starting_slots = pane.starting_slots.value;
    
	    list = pane.arena_picker.scroll_list.id;
    
	    match.arena = ds_map_find_value(DB.arenas,list.cur_item);
	    match.arena_name = ds_list_find_value(DB.arena_names,list.cur_item);
    
	    match.ban_black = pane.ban_black.checked;
	    match.sudden_death = pane.sudden_death.checked;
	    match.simple_mode = pane.simple_mode.checked;
	    match.hp_death = pane.hp_death.checked;
	    match.weak_terrain = pane.weak_terrain.checked;
	    match.tutorials = pane.tutorials.checked;
	    match.bolt_rain = pane.bolt_rain.checked;
    
	    close_frame(matchwindow);
	    goto_arena();
	}
	*/


}
