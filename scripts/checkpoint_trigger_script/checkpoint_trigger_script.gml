function checkpoint_trigger_script() {
	var guy = other;
	var player = guy.my_player;
	var player_num = player.number;

	if(is_undefined(spawn_points[? player_num]) && guy_can_capture_spawner(guy, id))
	{
	    visible = false;
	    if(!invisible)
	    {
	        effect_create_above(ef_firework, x,y, 2,c_white);
	        my_sound_play(gate_on_sound);
	    }
	    /*
	    other.my_spawner = id;
	    other.my_player.my_spawner = id;
	    if(instance_exists(other.my_player.my_camera))
	    {
	        other.my_player.my_camera.my_spawner = id;
	    }
	    */
    
	    // CREATE SPAWN POINT
	    guy_spawn_point_create(id, player);
	    /*
	    ii = instance_create(x,y, guy_spawn_point_obj);
	    ii.my_spawner = id;
	    ii.my_player = other.my_player;

	    self.spawn_points[? other.my_player.number] = ii;
	    */
	}



}
