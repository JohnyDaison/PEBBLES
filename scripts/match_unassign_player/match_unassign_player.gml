function match_unassign_player() {
	pane = match_setup_window.players_pane.id;

	self.enabled = false;
	pane.player_num -= 1;

	pane.player_names[index].text = pane.player_names[index].orig_text;
	pane.number_labels[index].text = pane.number_labels[index].orig_text;

	for(var i=0;i<4;i+=1)
	{
	    if(pane.number_labels[i].text = "2")
	    {
	        pane.number_labels[i].text = "1";
	    }
	}

	pane.assign_buttons[index].enabled = true;
	if(pane.player_num < pane.min_player_num)
	{
	    match_setup_window.start_button.enabled = false;
	}







}
