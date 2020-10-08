function mod_chb_user_click_script() {
	var gmmod_customs = play_menu_window.gamemode_pane.gmmod_customs;

	if(!is_undefined(gmmod_customs[? gmmod_id]))
	{
	    ds_map_delete(gmmod_customs, gmmod_id);
	}
	else
	{
	    gmmod_customs[? gmmod_id] = self.checked;
	}

	script_execute(onmouseover_script);



}
