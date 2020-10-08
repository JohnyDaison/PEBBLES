function terrain_grid_insert() {
	my_list = ds_grid_get(singleton_obj.terrain_grid,
	          floor((x-place_obj.x)/singleton_obj.grid_cell_size),
	          floor((y-place_obj.y)/singleton_obj.grid_cell_size));
	ds_list_add(my_list,self.id);



}
