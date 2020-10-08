function terrain_hor_shift() {
	with(editor_terrain_obj)
	{
	    if(x >= 0)
	    {
	        x += 32*terrain_placer_toolbar.hor_shift_input.value;
        
	        if(x < place_obj.x || x >= place_obj.x + place_obj.width)
	        {
	            instance_destroy();
	        }
	        else
	        {
	            event_perform(ev_destroy,0);
	            event_perform(ev_create,0);
	        }
	    }
	}



}
