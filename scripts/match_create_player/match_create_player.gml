function match_create_player() {
	pane = match_setup_window.players_pane.id;
	list = pane.player_picker.scroll_list.id;
	new_name = pane.new_name.text;
	while(string_char_at(new_name,1) == " ")
	{   
	    new_name = string_delete(new_name, 1, 1);
	}
	while(string_char_at(new_name,string_length(new_name)) == " ")
	{
	    new_name = string_delete(new_name, string_length(new_name), 1);
	}

	if(new_name != pane.new_name.prompt_str && new_name != "")
	{
	    if(ds_list_find_index(list.items,new_name) == -1)
	    {
	        ds_list_add(list.items,new_name);
	        ds_list_sort(list.items,true);
	        list.item_count = ds_list_size(list.items);
	        list.cur_item = ds_list_find_index(list.items,new_name);
	        list.selection_pos = min(list.cur_item,list.max_items-1);
	        pane.new_name.text = pane.new_name.prompt_str;
	    }
	}



}
