function terrain_grid_remove() {
	if(my_list != noone)
	{
	    my_index = ds_list_find_index(my_list,self.id);
	    if(my_index != -1)
	    {
	        ds_list_delete(my_list,my_index);
	    }
	}
	my_list = noone;



}
