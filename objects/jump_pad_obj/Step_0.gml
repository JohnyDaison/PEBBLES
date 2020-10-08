visible = true;
gravity_direction = 270;
gravity = 0;
friction = 0;
speed = min(speed,max_speed);

jump_power = min(jump_power + recharge_speed,max_power);
/*
last_color = my_color;
my_color = ceil(g_white*(jump_power/DB.max_jump_pad_power));
if(last_color != my_color)
{
    tint_updated = false;
}
*/
tint = merge_colour(black_tint, white_tint, jump_power/max_power);
self.ready = (jump_power >= min_power);
 
if(airborne)
{
    gravity = 0.12;
    friction = 0.06;
    
    if(y > room_height+32)
    {
        instance_destroy();
        exit;
    }
    
    if(place_meeting(x+hspeed,y+vspeed,terrain_obj))
    {
        if(abs(speed) >= 1)
        {
            my_move_bounce(terrain_obj);
            vspeed *= 0.25;
            hspeed *= 0.6;
            
            nearest_guy = instance_nearest(x,y,player_guy);
            if(nearest_guy != noone)
            {
                if(point_distance(x,y,nearest_guy.x,nearest_guy.y) < DB.sound_cutoff_dist)
                {  
                    my_sound_play(hit_ground_sound, true);
                    // TODO: Add structure_bounce_sound
                }
            }
        }
        else
        {
            y -= 1;
            speed = 0;
            gravity = 0;
            //center_y = y-hover_offset;
            airborne = false;
        }
    }
}
else
{
    if(!place_meeting(x,y+2,terrain_obj))
    {
        airborne = true;
    }
}

if(self.ready)
{
    with(guy_obj)
    {
        // TODO: IF JUMP PAD DIRECTION CHANGES, THIS HAS TO CHANGE TOO
        if(vspeed >= 0)
        {
            var full_speed_meeting = place_meeting(x+hspeed,y+vspeed+1,other);
            var half_speed_meeting = place_meeting(x+hspeed/2,y+vspeed/2+1,other);
            var speed_coef = 0;
            if(full_speed_meeting)
            {
                speed_coef = 1;
            }
            if(half_speed_meeting)
            {
                speed_coef = 0.5;
            }
            
            if(full_speed_meeting || half_speed_meeting)
            {
                //show_debug_message('place_meeting passed');
                if(!other.active)
                {
                    //show_debug_message(string(airborne) + ' ' + string(vspeed));
                }
                with(other)
                {
                    var that_guy = other.id;
                    
                    var y_diff = that_guy.y+24 -(y+vspeed);
                    var x_diff = that_guy.x+that_guy.hspeed*speed_coef - x;

                    if(y_diff < 1 && abs(x_diff) <= sprite_width/2)
                    {
                        i = instance_nearest(x,y,impact_obj);
                        if(instance_exists(i))
                        {
                            with(i)
                            {
                                if(my_guy == that_guy)
                                {
                                    instance_destroy();
                                }
                            }
                        }
                        if(self.active && !that_guy.wanna_run)
                        {
                            //show_debug_message('activated');
                            with(that_guy)
                            {
                                motion_add(90,other.jump_power);   
                            }
                            that_guy.y -= self.jump_power;
                            
                            my_sound_play(guy_bounce_sound, true);
                            self.jump_power = 0;
                            self.ready = false;
                            self.active = false;
                        }
                        
                        
                        
                        //show_debug_message("diffs: " + string(y_diff) + ' ' + string(x_diff));
                        // TRIGGER
                        if(self.ready && !that_guy.wanna_run) //   
                        {
                            //show_debug_message('trigger triggered');
                            that_guy.x = x;
                            that_guy.y = y+vspeed-24;
                            that_guy.speed = 0;
                            that_guy.gravity = 0;
                            //that_guy.status_left[? "frozen"] += 5;
                            self.active = true;
                            that_guy.have_jumped = true;
                        }
                    }
                }
            }
        }
    }
}
