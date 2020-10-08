function add_cells() {
	add_amount = place_toolbar.add_input.value;

	add_pixels = 32*add_amount;

	if(add_amount < 0)
	{
	    if((add_dir == left || add_dir == right) && place_obj.width/32+add_amount < 10)
	    {
	        add_amount = 10 - place_obj.width/32;
	    }
	    if((add_dir == up || add_dir == down) && place_obj.height/32+add_amount < 10)
	    {
	        add_amount = 10 - place_obj.height/32;
	    }   
	}

	if(add_amount != 0)
	{
	    switch(add_dir)
	    {
	        case left:
	        { 
	            with(editor_object)
	            {
	                if(x < place_obj.x - other.add_pixels)
	                {
	                    instance_destroy();    
	                }
	                else
	                {
	                    x += other.add_pixels;
	                }
	            }
	            place_obj.width += add_pixels;
	            //editor_camera.x += add_pixels;
	        }    
	        break;
        
	        case right:
	        {
	            with(editor_object)
	            {
	                if(x >= place_obj.x + place_obj.width + other.add_pixels)
	                {
	                    instance_destroy();
	                }
	            }
	            place_obj.width += add_pixels;
	        }    
	        break;
        
	        case up:
	        {   
	            with(editor_object)
	            {
	                if(y < place_obj.y - other.add_pixels)
	                {
	                    instance_destroy();    
	                }
	                else
	                {
	                    y += other.add_pixels;
	                }
	            }
	            place_obj.height += add_pixels;
	            //editor_camera.y += add_pixels;
	        }    
	        break;
        
	        case down:
	        {
	            with(editor_object)
	            {
	                if(y >= place_obj.y + place_obj.height + other.add_pixels)
	                {
	                    instance_destroy();
	                }
	            }
	            place_obj.height += add_pixels;
	        }    
	        break;
	    }
    
	    with(editor_terrain_obj)
	    {
	            if(x >= place_obj.x && x < place_obj.x + place_obj.width
	            && y >= place_obj.y && y < place_obj.y + place_obj.height)
	            {
	                event_perform(ev_destroy,0);
	            }
	    }
    
	    with(singleton_obj)
	    {
	        event_perform(ev_other,ev_room_end);
	        event_perform(ev_other,ev_room_start);
	    }

	    with(editor_terrain_obj)
	    {
	            if(x >= place_obj.x && x < place_obj.x + place_obj.width
	            && y >= place_obj.y && y < place_obj.y + place_obj.height)
	            {
	                event_perform(ev_create,0);
	            }
	    }
	}



}
