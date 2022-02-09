if((self.my_color != other.my_color || self.my_color == g_octarine) || (xstart == x && ystart == y))
{
    collided = true;
    if(!wallhit_played)
    {
        my_sound_play(shot_wallhit_sound, false, sound_volume);
        wallhit_played = true;
    }
}

if(!bounced && !collided)
{
    var orig_x = x;
    var orig_y = y;
    
    x_return = xprevious - orig_x;
    y_return = yprevious - orig_y;
    
    var h_diff = xprevious - (other.x + other.obj_center_xoff);
    var v_diff = yprevious - (other.y + other.obj_center_yoff);
    
    var h_bounced = false;
    var v_bounced = false;
    
    orig_speed = speed;
    
    speed_delta = (other.energy/other.bounce_threshold -1) * other.bounce_speedchange_ratio;
    energy_delta = speed_delta * -other.bounce_speedenergy_ratio;
    last_wall_hit = other.id;
    
    if(abs(h_diff) <= 16 || abs(v_diff) <= 16)
    {
        if(abs(v_diff) >= abs(h_diff))
        {
            if(sign(v_diff) == -sign(vspeed)) // abs(hspeed) > abs(vspeed) && 
            {
                vspeed *= -1;
                bounced = true;
                v_bounced = true;
                corner_bounced = false;
                //show_debug_message("vert bounce");
            }
        }
        
        if(abs(h_diff) >= abs(v_diff))
        {
            if(sign(h_diff) == -sign(hspeed)) // abs(hspeed) < abs(vspeed) && 
            {
                hspeed *= -1;
                bounced = true;
                h_bounced = true;
                corner_bounced = false;
                //show_debug_message("hor bounce");
            }
        }
    }
    else
    {
        h_diff -= sign(h_diff)*12;
        v_diff -= sign(v_diff)*12;
        
        //show_debug_message("corner h_diff: "+string(h_diff));
        //show_debug_message("corner v_diff: "+string(v_diff));
        
        var normal_size = point_distance(0,0,h_diff,v_diff);
        var coef = speed/normal_size;
        
        //show_debug_message("coef: "+string(coef));
        
        hchange = coef*h_diff;
        vchange = coef*v_diff;
        
        corner_bounced = true;
        //show_debug_message("corner bounce found");
    }
    
    if(bounced)
    {
        var bounce_coef = max(0, 1 - self.wall_bounce_damping);
        
        if(orig_speed + speed_delta > 0.2) {
            speed = orig_speed + speed_delta;
            if(holographic == other.holographic)
            {
                other.energy += energy_delta;
            }
        }
        
        if(h_bounced && v_bounced) {
            speed *= bounce_coef;
        } else if(h_bounced) {
            hspeed *= bounce_coef;
        } else if(v_bounced) {
            vspeed *= bounce_coef;
        }
        
        if(abs(hspeed) <= 0.1 && h_bounced)
        {
            hspeed = 0;
        }
        
        if(abs(vspeed) <= gravity_coef && v_bounced)
        {
            vspeed = 0;
            gravity = 0;
        }
        
        if(speed > stopped_threshold)
        {
            my_sound_play_colored(shot_bounce_sound, my_color, false, sound_volume);
        }
    }
    else
    {
        if(!corner_bounced)
        {
            collided = true;
            if(!wallhit_played)
            {
                my_sound_play(shot_wallhit_sound, false, sound_volume);
                wallhit_played = true;
            }
        }
    }
}

if(collided && holographic == other.holographic)
{
    power_ratio = get_power_ratio(self.my_color,other.my_color);
    if(power_ratio != 0)
    {
        var body_dmg = force*power_ratio;

        other.scale_buffer += body_dmg;
        other.my_next_color = self.my_color;
        other.damage += body_dmg;
        if(!(other.color_locked && other.my_color == g_dark))
        {
            other.energy += abs(body_dmg);
        }
        
        other.last_dmg = body_dmg;

        with(other)
        {
            last_attacker_update(other.id, "body", "damage");
        }
        
        if((body_dmg > 1.5 || (other.unstable && body_dmg > 0.5)) && other.cover != cover_indestr)
        {
            other.falling = true;
        }
        
        impact_strength = body_dmg;
    
        if(body_dmg != 0)
        {
            create_damage_popup(body_dmg, my_color, other.id);
        }
    }
}
