function terrain_vert_shift() {
	with(editor_terrain_obj)
	{
	    if(y >= 0)
	    {
	        y += 32*terrain_placer_toolbar.vert_shift_input.value;
        
	        if(y < place_obj.y || y >= place_obj.y + place_obj.height)
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
