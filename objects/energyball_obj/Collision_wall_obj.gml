if((self.my_color != other.my_color || self.my_color == g_octarine) || (xstart == x && ystart == y))
{
    collided = true;
    if(!wallhit_played)
    {
        my_sound_play(shot_wallhit_sound);
        //my_sound_play_colored(shot_wallhit_sound, my_color);
        wallhit_played = true;
    }
}

if(!bounced && !collided)
{
    var orig_x = x;
    var orig_y = y;
    
    x_return = xprevious - orig_x;
    y_return = yprevious - orig_y;
    
    var h_diff = xprevious - (other.x+16);
    var v_diff = yprevious - (other.y+16);
    
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
        
        normal_size = point_distance(0,0,h_diff,v_diff);
        coef = speed/normal_size;
        
        //show_debug_message("coef: "+string(coef));
        
        hchange = coef*h_diff;
        vchange = coef*v_diff;
        
        corner_bounced = true;
        //show_debug_message("corner bounce found");
    }
    
    if(bounced)
    {
        /*
        if(speed > 0.2)
        {
            speed -= 0.2;
        }
        else
        {
            gravity = 0;
        }
        */
        if(orig_speed + speed_delta > 0.2)
        {
            speed = orig_speed + speed_delta;
            if(holographic == other.holographic)
            {
                other.energy += energy_delta;
            }
        }
        else
        {
            //speed = 0;
            gravity = 0;
        }
        
        speed = max(0, speed - self.wall_bounce_damping);
        if(speed > 0)
        {
            my_sound_play_colored(shot_bounce_sound, my_color);
        }
    }
    else
    {
        if(!corner_bounced)
        {
            collided = true;
            if(!wallhit_played)
            {
                my_sound_play(shot_wallhit_sound);
                //my_sound_play_colored(shot_wallhit_sound, my_color);
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
        if(!(other.color_locked && other.my_color == g_black))
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
