if(!bounced)
{
    var orig_x = x;
    var orig_y = y;
    
    x_return = xprevious - orig_x;
    y_return = yprevious - orig_y;
    
    var h_diff = xprevious - (other.x+15);
    var v_diff = yprevious - (other.y+15);
    
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
            other.energy += energy_delta;
        }
        else
        {
            //speed = 0;
            gravity = 0;
        }
        
        if(abs(speed) < 0.2)
        {
            speed = 0;
        }
    }
}

//other.my_next_color = irandom_range(g_red, g_cyan);

/*
if(collided)
{
    power_ratio = get_power_ratio(self.my_color,other.my_color);
    if(power_ratio != 0)
    {
        body_dmg = force*power_ratio;
        
        other.my_next_color = self.my_color;
        other.damage += body_dmg;
        other.last_dmg = body_dmg;
        other.energy += abs(body_dmg);
        other.last_attacker = my_player;
        other.last_attacker_guy = my_guy;
        if(body_dmg > 1.5 && other.cover != cover_indestr)
            other.falling = true;
        
        impact_strength = body_dmg;
    
        if(body_dmg != 0)
        {
            i = instance_create(other.x,other.y,damage_popup_obj);
            i.damage = body_dmg;
            i.my_color = my_color;
            i.tint_updated = false;
            i.source = other.id;
        }
    }
}
*/

/* */
/*  */
