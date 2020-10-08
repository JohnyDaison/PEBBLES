function match_delete_player() {
	pane = match_setup_window.players_pane.id;
	list = pane.player_picker.scroll_list.id;

	if(list.item_count > 0)
	{
	    ds_list_delete(list.items,list.cur_item);   
	}



}
