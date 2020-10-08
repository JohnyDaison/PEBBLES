function random_color() {
	col = irandom(7);
	return ds_map_find_value(DB.colormap,col);



}
