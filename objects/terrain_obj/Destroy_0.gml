// GRID

terrain_deregister(singleton_obj, id);
/*
ds_list_delete(my_list,ds_list_find_index(my_list,self.id));
*/

ds_map_destroy(near_walls);

regenerate_nav_graph();

event_inherited();
