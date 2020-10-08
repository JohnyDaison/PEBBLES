function grid_drawer_toggle() {
	if(instance_exists(grid_drawer))
	{
	    with(grid_drawer)
	    {
	        instance_destroy();
	    }
	}
	else
	{
	    instance_create(0,0,grid_drawer);
	}



}
