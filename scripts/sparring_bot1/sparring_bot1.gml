function sparring_bot1(argument0) {
	if(npc_active || phase != 0)
	{
	    var near_player = argument0;
	    var pl_dist = 0;
	    if(instance_exists(near_player))
	    {
	        pl_dist = point_distance(x,y, near_player.x, near_player.y);
	    }
	    else
	    {
	        if(phase >= 2)
	        {
	            phase = 2;
	        }
	    }
    
	    if(phase == 0)
	    {
	        var new_color = 3;
	        while(new_color == 3)
	        {
	            new_color = irandom(3)+1;
	        }
	        if(random(5) < 1)
	        {
	            ds_list_add(new_colors, new_color);
	        }
	        if(current_slot > 0 && ((irandom(2) <= current_slot) || (current_slot == 2 && pl_dist > third_attack_range)))
	        {
	            if(!instance_exists(my_shield) && shield_ready)
	            {
	                self.hor_dir_held = false;
	            }
	            else
	            {
	                if(instance_exists(near_player))
	                {
	                    self.hor_dir_held = (abs(x - near_player.x) > 64 || abs(y - near_player.y) < 32);
	                }
	                else
	                {
	                    self.hor_dir_held = true;
	                }
	            }
	            self.wanna_cast = true;
            
	            phase = 1;
	        } 
	    }
	    if(phase == 1)
	    {
	        if(self.charging && charge_ball != noone)
	        {
	            if(charge_ball.charge >= ( 0.75 * min(1,difficulty) * charge_ball.threshold) && random(10/difficulty)<1)
	            {
	                self.wanna_cast = false;
	                phase = 2;
	            }
	        } 
	    }
    
	    if(phase >= 2)
	    {
	        phase++;
        
	        if(phase >= round(10/difficulty))
	        {
	            phase = 0;
	        }
	    }
    
	    // MOVEMENT
	    if((step_count - last_direction_change) > direction_change_min_time
	    && step_count mod direction_change_min_time == 0)
	    {
	        looking_up = false;
	        looking_down = false;
	        desired_aim_dir = 0;
	        desired_aim_dist = 0;
        
	        // TRY TO AIM AT PLAYER     
	        if(instance_exists(near_player))
	        {
	            facing_right = !!(sign(near_player.x - x));
	            if(random(2/difficulty) < 1) { looking_up = (y - near_player.y) > 48; }
	            if(random(2/difficulty) < 1) { looking_down = (near_player.y - y) > 48; }
	            last_direction_change = step_count;
            
	            if(pl_dist < attack_min_range)
	            {
	                self.wanna_run = false;
	                self.wanna_look = true;
	            }
            
	            desired_aim_dir = point_direction(x,y, near_player.x, near_player.y);
	            desired_aim_dist = 1;
	        }
        
	        // RANDOM AIM VS RUN
	        if(random(3) < 1)
	        {
	           self.wanna_run = false;
	           self.wanna_look = true;
	        }
        
	        if(random(3) < 1)
	        {
	           self.wanna_run = true;
	           self.wanna_look = false;
	        }
        
	        // JUMPING
	        if(self.holding_wall)
	        {
	            //self.wanna_jump = false; //!self.have_jumped
	            if(self.wanna_jump || self.have_jumped)
	            {
	                self.wanna_jump = false;   
	                self.have_jumped = false;   
	            }
	            else
	            {
	                self.wanna_jump = true;
	                self.wanna_run = true;
	                self.looking_up = true;
	            }
	        }
	        else if(!self.wanna_cast && random(2/difficulty) < 1)
	        {
	           self.wanna_jump = !self.wanna_jump;
	        }
        
	        // SELF SUSTAIN
	        if(random(36/sqrt(difficulty)) < 1)
	        {
	            var batt = instance_create(x,y, orb_battery_obj);
	            batt.my_guy = id;
	            with(batt)
	            {
	                event_perform(ev_other, ev_user1);
	                instance_destroy();
	            }
	        }
        
	        /* too pacifist
	        if(phase == 2 && random(1.5) < 1)
	        {
	            phase = 0;
	        }
	        */
        
	        if(!npc_active)
	        {
	            self.hor_dir_held = false;
	            self.wanna_cast = false;
	            self.wanna_run = false;
	            self.wanna_look = false;
	            self.wanna_jump = false;
            
	            phase = 0;
	        }
	    }
	}



}
