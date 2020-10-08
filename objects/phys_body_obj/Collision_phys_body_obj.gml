if(object_is_ancestor(other.object_index, guy_obj))
{
    push_hstrength = other.running*other.running_power/2;
    push_vstrength = other.jumping_glidepower/2;
    other_ok = !other.lost_control;
    if(other_ok && !is_shielded(id) && !protected)
    {
        push_hstrength = max(push_hstrength,2*abs(other.hspeed)/other.max_speed);
        push_vstrength = max(push_vstrength,2*abs(other.vspeed)/other.max_speed);
    }
}
else if(other.object_index == slime_mob_obj)
{
    push_hstrength = 1;
    push_vstrength = 1.5;
    other_ok = true;  
}
else if(other.object_index == sprinkler_body_obj)
{
    push_hstrength = max(abs(hspeed*0.5), abs(other.hspeed));
    push_vstrength = max(abs(vspeed*0.5), abs(other.vspeed));
    other_ok = true; 
}
else if(other.object_index == spitter_body_obj)
{
    push_hstrength = max(abs(hspeed*0.1), abs(other.hspeed*0.2));
    push_vstrength = max(abs(vspeed*0.1), abs(other.vspeed*0.2));
    other_ok = true; 
}

if(other_ok)
{
    if(object_is_ancestor(object_index, guy_obj))
    {
        if(lost_control) {
            other_ok = false;
        }
    }
    
    if(other.holographic != self.holographic)
    {
        other_ok = false;
    }
}    

if(other_ok)
{
    // SLIME SPLAT DAMAGE
    if(object_is_ancestor(other.object_index, guy_obj) && object_index == slime_mob_obj)
    {
        if(other.vspeed > splat_speed && abs(other.hspeed) < other.vspeed)
        {
            damage += other.vspeed - splat_speed;
            last_attacker_update(other.id, "body", "damage");
        }
    }    
    
    if(other.object_index == slime_mob_obj)
    {
        if(object_index == slime_mob_obj)
        {
            // SLIME ENERGY EXCHANGE
            var diff = energy - other.energy;
            var receiver = other.id;
            
            if(abs(diff) >= touch_damage)
            {
                diff = sign(diff) * touch_damage/2;
                tint = DB.colormap[? other.my_color];
                other.tint = DB.colormap[? my_color];
                tint_updated = false;
                other.tint_updated = false;
                
                if(diff < 0) {
                    receiver = id;
                }
                energy -= diff;
                other.energy += diff;
                //create_damage_popup(abs(diff), receiver.my_color, receiver, "slime_transfer");
            }
        }
        else
        {
            // SLIME TOUCH
            if(other.energy > other.touch_damage_threshold)
            {
                receive_damage(other.touch_damage*other.energy/other.base_energy);
            }
        }
    }

    
    // PUSH
    
    x_dist = x - other.x;
    y_dist = y - other.y;
    
    /*
    dir = point_direction(other.x,other.y,x,y);
    */
    //dist = point_distance(other.x,other.y,x,y);
    
    if(x_dist == 0)
    {
        x_dist = round(random(1))*2 -1;
        push_hstrength = max(0.1,push_hstrength);
    }
    /*
    if(y_dist == 0)
    {
        y_dist = round(random(1))*2 -1;
        push_vstrength = max(0.1,push_vstrength);
    }
    */
    
    x_dist = sign(x_dist)*push_hstrength;
    y_dist = sign(y_dist)*push_vstrength;
    
    phys_body_obj_push_other(coltype_var);
 
    with(other)
    {
        x_dist = -other.x_dist;
        y_dist = -other.y_dist;
        
        phys_body_obj_push_other(coltype_var);
    }
}
