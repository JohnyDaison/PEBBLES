function goto_playmenu() {
	/*
	close_frame(main_menu_window);
	close_frame(match_summary_window);
	add_frame(play_menu_window);


	if(room != mainmenu)
	{
	*/      
	    while(instance_exists(empty_frame))
	    {
	        close_frame(empty_frame);
	    }
    
	    with(world_obj)
	    {
	        instance_destroy();
	    }

	    with(gamemode_obj)
	    {
	        instance_destroy();
	    }
    
	    add_frame(play_menu_window)
	/*    
	}
	else
	{
	    while(instance_exists(empty_frame))
	    {
	        close_frame(empty_frame);
	    }
    
	    add_frame(play_menu_window);
	}


/* end goto_playmenu */
}
