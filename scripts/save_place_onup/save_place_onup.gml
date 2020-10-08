function save_place_onup() {
	if(room == level_editor && !instance_exists(save_tool))
	{
	    instance_create(0,0,save_tool);
	}



}
