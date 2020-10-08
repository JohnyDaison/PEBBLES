function teleporter_trigger_script() {
	if(self.ready)
	{
	    var that_body = other.id;
	    var that_guy = noone;
	    var is_guy = false;
    
	    if(object_is_child(that_body, guy_obj))
	    {
	        is_guy = true;
	        that_guy = that_body;
	    }
    
	    var ok_to_teleport = (!is_guy) || 
	                        (is_guy && 
	                            !(that_guy.is_npc && that_guy.bot_type = "tut_guide"));
    
	    if(!ok_to_teleport)
	    {
	        return;   
	    }
    
	    var old_x = that_body.x;
	    var old_y = that_body.y;
    
	    effect_create_above(ef_firework,that_body.x,that_body.y,2,self.tint);
    
	    that_body.x = x + self.tp_xx;
	    that_body.y = y + self.tp_yy;
	    that_body.speed = 0;
    
	    /*
	    if(that_guy.is_npc) 
	    {
	        ds_list_clear(that_guy.current_path);
	        that_guy.npc_waypoint = "";
	        that_guy.npc_last_waypoint = "";
	        that_guy.npc_destination_x = that_guy.x;
	        that_guy.npc_destination_y = that_guy.y;
	        that_guy.destination_mode = false;
	        that_guy.npc_destination_reached = true;
	    }
	    */
    
	    if (is_guy)
	    {
	        var cam = that_guy.my_player.my_camera;
    
	        if(instance_exists(cam))
	        {
	            cam.x += that_guy.x - old_x;
	            cam.y += that_guy.y - old_y;
	        }
	    }
    
	    effect_create_above(ef_firework,that_body.x,that_body.y,2,self.tint);
    
	    my_sound_play(tp_sound);
	    self.jump_power = 0;
	    self.ready = false;
	    self.active = false;
	}



}
