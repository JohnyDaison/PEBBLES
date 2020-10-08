function spawn_points_destroy() {
	for(var player_i = 0; player_i <= gamemode_obj.player_count; player_i++)
	{
	    var point = spawn_points[? player_i];
    
	    if(!is_undefined(point))
	    {
	        instance_destroy(point);
	    }
	}
	ds_map_destroy(spawn_points);


}
