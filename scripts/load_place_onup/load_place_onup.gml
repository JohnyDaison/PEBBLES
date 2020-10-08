function load_place_onup() {
	if(room == level_editor && !instance_exists(load_tool))
	{
	    instance_create(0,0,load_tool);
	}



}
