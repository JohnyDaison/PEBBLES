///@param source
///@param type
///@param color
///@param energy
function create_energy_ball() {

	var source = argument[0];
	var type = argument[1];
	var color = argument[2];
	var energy = argument[3];

	var ball;

	if(instance_exists(source))
	{
	    switch (type)
	    {
	        case "small_bolt_rain":
	            ball = instance_create(source.x, source.y, small_projectile_obj);
	            break;
        
	        case "small_bolt":
	            ball = instance_create(source.x, source.y, small_projectile_obj);
	            if(y > 0)
	            {
	                //my_sound_play_colored(shot1_sound, color);
	                my_sound_play(shot1_sound);
	            }
	            break;
            
	        case "big_bolt":
	            ball = instance_create(source.x, source.y, big_projectile_obj);
	            if(y > 0)
	            {
	                //my_sound_play_colored(shot1_sound, color);
	                my_sound_play(shot1_sound);
	            }
	            break;
            
	        case "artillery_shot":
	            ball = instance_create(source.x, source.y, artillery_projectile_obj);
	            if(y > 0)
	            {
	                //my_sound_play_colored(artillery_shot_sound, color, true);
	                my_sound_play(artillery_shot_sound, true);
	            }
	            break;
            
	        case "slime_ball":
	            ball = instance_create(source.x, source.y, slime_ball_obj);
	            break;
	    }
	}

	if(instance_exists(ball))
	{
	    ball.my_player = source.my_player;
	    if(instance_exists(source.my_guy))
	    {
	        ball.my_guy = source.my_guy.id;
	    }
	    else
	    {
	        ball.my_guy = ball.id;
	    }
    
	    with(ball)
	    {
	        if(my_guy != id)
	        {
	            has_left_update(my_guy, false);
	        }
	    }
    
	    ball.my_source = source.object_index;
	    ball.holographic = source.holographic;
	    ball.my_color = color;
	    ball.tint_updated = false;
	    ball.force = energy;
	}

	return ball;


}
