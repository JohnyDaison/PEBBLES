function status_ubershield_start() {
	if(has_level(id, "shield" , 1))
	{
	    var abi_color = g_purple;
	    if(!instance_exists(my_shield))
	    {
	        if(my_color != g_black)
	        {
	            i = instance_create(x,y,shield_obj);
	            i.my_guy = self.id;
	            i.my_player = self.my_player;
	            i.max_charge = self.shield_max_charge;
	            i.charge = i.max_charge;
	            i.size_coef = self.shield_size;
	            i.my_color = self.my_color;
	            my_shield = i;
	            self.shield_ready = true;
	        }
	    }
    
	    if(instance_exists(my_shield))
	    {
	        my_shield.charge = clamp(my_shield.charge*2, my_shield.max_charge, shield_threshold); 
	        my_shield.overcharge += ball_ubercharge_boost;
	        self.shield_overcharge += ball_ubercharge_boost;
	        my_sound_play(ubershield_sound);
	    }
	    else
	    {
	        abi_cooldown[? abi_color] = 1;
	        status_left[? "ubershield"] = 0;
	    }
    
    
	}



}
