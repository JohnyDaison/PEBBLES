function update_status_effects() {
	var effect_id, effect;

	for(var i=0; i < DB.status_effect_count; i++)
	{
	    effect_id = DB.status_effects_list[| i];
        effect = DB.status_effects[? effect_id];
    
	    // STEP SCRIPT
	    if(status_left[? effect_id] > 0)
	    {
	        script_execute(effect.step_script);
	    }

	    // STATUS DECAY
	    var status_decay = 1;
	    if(effect.buff == -1 && my_color == effect.color)
	    {
	        status_decay += 1;
	    }
    
	    status_left[? effect_id] -= status_decay;
    
	    // MIN
	    if(self.status_left[? effect_id] < 0)
	    {
	        self.status_left[? effect_id] = 0;
	    }
  
	    // MAX
	    if(effect.max_duration > 0 && status_start[? effect_id] != -1)
	    {
	        var total_time = step_count - status_start[? effect_id];
	        if(total_time >= effect.max_duration)
	        {
	            self.status_left[? effect_id] = 0;
	            status_start[? effect_id] = -1;
	            script_execute(effect.end_script);
	            self.protected = true;
	            alarm[2] = recover_time;
	        }
	    }
    
	    // HANDLE PARTICLES
	    if(self.status_left[? effect_id] > 0)
	    {
	        if(!instance_exists(self.status_particles[? effect_id]))
	        {
	            var ps = effect.particle_system;
	            if(ps != noone)
	            {
	                ii = instance_create(x,y, ps);
	                ii.my_guy = id;
	                ii.tint = DB.colormap[? effect.color];
	                ii.alarm[0] = 2;
	                ii.alarm[1] = 0;
                
	                self.status_particles[? effect_id] = ii; 
                
	                i = instance_create(x,y-24,text_popup_obj);
	                i.str = DB.status_effects[? effect_id].name + "!";
	                i.my_color = DB.status_effects[? effect_id].color;
	                i.tint_updated = false;
	            }
	        }
	        else
	        {
	            var particles = self.status_particles[? effect_id];
	            particles.alarm[0] = 2;
	            particles.alarm[1] = 0;
	            particles.active = true;
	        }
	    }
	}
}
