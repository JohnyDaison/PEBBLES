event_inherited();
var vortex = id;

var dist, dir, is_energyball, coef, max_force, max_dist, attr_force;
with(guy_obj)
{
    if(holographic == vortex.holographic)
    {
        dist = point_distance(x, y, vortex.x, vortex.y);
        if(old_coef == 0)
        {
            old_coef = gravity_coef;
        }
        
        ubershielded = is_shielded(id, "uber");
        
        if(dist < vortex.radius)
        {
            if(my_player.id != vortex.my_player.id && !protected)
            {
                if(ubershielded)
                {             
                    my_shield.charge -= 0.01;
                    my_sound_play(wall_hum_sound);
                    //my_sound_play_colored(wall_hum_sound, my_shield.my_color);
                }    
                else if(vortex.force != 0 && my_color != g_dark)
                {        
                    // SLOT THEFT
                    /*
                    if(current_slot > 0 && !lost_control && !slots_triggered)
                    {
                        vortex.slot = ds_list_find_value(self.color_slots,0);
                        if(instance_exists(vortex.slot))
                        {
                            if(vortex.slot.color_added || vortex.slot.color_held)
                            {
                                with(vortex.slot)
                                {
                                    color_consumed = false;
                                    color_held = true;
                                    old_guy = my_guy.id;
                                    my_guy = vortex.id;
                                    speed = my_guy.speed;
                                    direction = my_guy.direction;
                                }
                                
                                ds_list_delete(color_slots,0);
                                
                                self.slots_triggered = false;
                                self.current_slot = 0;
                                self.potential_abi_name = "";
                                self.slot_number -= 1;
                                
                                for(i = 0; i < self.slot_number; i += 1)
                                {
                                    slot = ds_list_find_value(self.color_slots,i);
                                    slot.color_added = false;
                                    slot.color_held = false;
                                    slot.color_consumed = false;
                                    slot.sprite_index = noone;
                                }
                                
                                alarm[3] = 1;
                                show_debug_message("Loser!");
                                
                                ds_list_add(vortex.stolen_slots,vortex.slot.id);
                                vortex.slot_count = ds_list_size(vortex.stolen_slots);
                            }
                        }
                    }
                    */
                    
                    // THROWING AROUND
        
                    dir = point_direction(x,y,vortex.x,vortex.y);
                    /*
                    if(dist < vortex.radius/6)
                    {
                        dist = vortex.radius/6;
                    }
                    */
                    coef = (1 - dist/vortex.radius)*8*vortex.force;
                    
                    /*
                    if(vspeed == 0)
                        vspeed = sign(vortex.y-y);
                    */
                    motion_add(dir,coef);
                    
                    if(dist<(vortex.radius/3) || lost_control)
                    {
                        lost_control = true;
                        hit_handled = false;
                    }
                    
                    if(lost_control && !hit_handled)
                    {
                        if(sign(lengthdir_x(dist,dir))!=facing)
                        {
                            back_hit = true;
                        }
                        else
                        {
                            front_hit = true;
                        }
                        
                        var params = create_params_map();
                        params[? "who"] = vortex.my_guy;
                        
                        broadcast_event("vortex_knockdown", id, params);
                    }
                    
                    last_attacker_update(vortex.id, "body", "dark");
                }
            }
        }
        /*
        // RETURN GRAVITY BACK TO NORMAL
        else if(gravity_coef != old_coef || gravity_direction != 270)
        {
            gravity_direction = 270;
            gravity_coef = old_coef;
            y-=1;
            airborne = false;
        }*/
    }
}


// ATTRACT ORBS
with(color_orb_obj)
{
    if(holographic == vortex.holographic)
    {
        if(instance_exists(my_guy))
        {
            if(my_guy.id == id)
            {
                dist = point_distance(x,y,vortex.x,vortex.y);
                
                if(dist < vortex.radius)
                {
                    my_guy = vortex.id;
                    ds_list_add(vortex.stolen_slots, id);
                    vortex.slot_count = ds_list_size(vortex.stolen_slots);
                    speed = vortex.speed;
                    direction = vortex.direction;
                }
            }
        }
    }
}

// ATTRACT ITEMS
with(item_obj)
{
    if(holographic == vortex.holographic)
    {
        if(instance_exists(my_guy))
        {
            if(!is_shielded(id) && (
                (my_guy.id == id && collectable && !collected)
                || (!collected && placed && stuck_to == noone) 
            ))
            {
                dist = point_distance(x,y,vortex.x,vortex.y);
                
                if(dist < vortex.radius)
                {
                    my_guy = vortex.id;
                    ds_list_add(vortex.picked_pickups, id);
                    vortex.pickup_count = ds_list_size(vortex.picked_pickups);
                    speed = vortex.speed;
                    direction = vortex.direction;
                }
            }
        }
    }
}

// BOLT ATTRACTION

with(projectile_obj)
{
    if(holographic == vortex.holographic)
    {
        if(id != vortex.id)
        {
            dist = point_distance(x,y,vortex.x,vortex.y);  
            is_energyball = object_is_ancestor(object_index,energyball_obj);
            
            if(is_energyball)
            {
                max_force = 0.75;
                max_dist = 256;
            }    
            else
            {
                max_force = 0.5;
                max_dist = 512;
            }
            if(dist > 0 && dist < max_dist)
            {
                dir = point_direction(x,y,vortex.x,vortex.y);
                attr_force = max_force*(1 - max(dist-vortex.radius,0)/max(max_dist-vortex.radius,1));
                motion_add(dir,attr_force);
            }
        }
    }
}

// MOB ATTRACTION
with(mob_obj)
{
    if(holographic == vortex.holographic && vortex.my_color != my_color)
    {
        dist = point_distance(x,y,vortex.x,vortex.y);  
        max_force = 5;
        max_dist = 192;
    
        if(dist > 0 && dist < max_dist)
        {
            dir = point_direction(x,y,vortex.x,vortex.y);
            attr_force = max_force*(1 - max(dist-vortex.radius,0)/max(max_dist-vortex.radius,1));
            motion_add(dir,attr_force);
            
            last_attacker_update(vortex.id, "body", "dark");
        }
    }
}

// RETURN TO SENDER
if(instance_exists(my_guy))
{
    dist = point_distance(x,y,my_guy.x,my_guy.y);
    dir = point_direction(x,y,my_guy.x,my_guy.y);
    
    motion_add(dir,gravity_ratio/force);
    
    if(gravity_ratio >= force)
    {
        speed *= 1-orig_friction;
    
        if((dist <= return_distance_limit
            && abs(hspeed-my_guy.hspeed) <= return_max_axisdelta
            && abs(vspeed-my_guy.vspeed) <= return_max_axisdelta)
        || my_guy.dead)
        {
            instance_destroy();
        }
    }
}
else
{
    instance_destroy();
    exit;
}

// BOLT LIFECYCLE
force_step = 0.01*force;
force_used += force_step;
gravity_ratio += force_step;
if(gravity_ratio > force)
    gravity_ratio = force;
    
trail_delay = min_trail_delay +
    clamp(2-sqr(force_used/force), 0, 1)*(start_trail_delay-min_trail_delay);

if(alarm[2] > trail_delay)
{
    alarm[2] = trail_delay;
} 
/*if(force_used >= force)
{
    instance_destroy();
}*/
