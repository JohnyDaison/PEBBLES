function match_assign_player() {
	var pane = match_setup_window.players_pane.id;
	var list = pane.player_picker.scroll_list.id;
	var name,name_OK;

	if(list.cur_item != -1 && pane.player_num < pane.max_player_num)
	{
	    name = ds_list_find_value(list.items,list.cur_item);
    
	    name_OK = true;
	    for(i=0; i<4 && name_OK; i+=1)
	    {       
	       if(pane.player_names[i].text == name)
	       {
	            name_OK = false;
	       }
	    }
    
	    if(name_OK)
	    {
	        pane.player_names[index].text = name;
	        self.enabled = false;
	        pane.unassign_buttons[index].enabled = true;
	        pane.player_num += 1;
	        pane.number_labels[index].text = string(pane.player_num);
	    }
    
	    if(pane.player_num >= pane.min_player_num)
	    {
	        match_setup_window.start_button.enabled = true;
	    }
	}



}
