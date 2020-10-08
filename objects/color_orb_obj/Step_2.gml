if(singleton_obj.paused)
{
    exit;
}

/// STATE STARTS, ORBIT BEHAVIOURS, WALL AND SLIME DRAIN
if(color_added && (sprite_index != color_slot_appear || invisible))
{
    invisible = false;
    //visible = true;
    sprite_index = color_slot_appear;
    image_speed = 0.4;
    image_index = 0;
    size_coef = 1;

    if(!instance_exists(orbit_anchor) && instance_exists(my_guy) && (object_is_ancestor(my_guy.object_index, guy_obj) || my_guy.object_index == charge_ball_obj))
    {
        orbit_anchor = my_guy.id;
    }

    //color_in_use = false;
    
}
if(color_held && sprite_index != color_slot)
{
    sprite_index = color_slot;
}
if(color_consumed)
{ 
    color_held = false;
    if(sprite_index != color_slot_disappear)
    {
        sprite_index = color_slot_disappear;
        //image_index = 0;
        image_speed = 1;
    }
    if(instance_exists(orbit_anchor))
    {   
        my_distance = (orbit_anchor.orb_dist)*(1-(image_index/image_number));
    }
    if(object_is_ancestor(my_guy.object_index, guy_obj))
    {
        if(my_guy.abi_triggered || my_guy.charging)
        {
            image_index = image_number-2*image_speed;  
        }
    }
}    

if(!instance_exists(my_guy))
{
    instance_destroy();
    show_debug_message("ERROR: ORB DIED OF LONELINESS!!!");
    exit;
}

// ORBITING
if(instance_exists(orbit_anchor))
{  
    var xx, yy;
    
    my_distance = orbit_anchor.orb_dist;
    base_size = orbit_anchor.orb_base_size;
    if(!invisible)
    {
        if(object_is_child(orbit_anchor, guy_obj))
        {
            if(orbit_anchor.has_tped)   
            {
                x += orbit_anchor.x - orbit_anchor.pre_tp_x;
                y += orbit_anchor.y - orbit_anchor.pre_tp_y;
            }
        }
        
        xx = orbit_anchor.x + (cos(my_angle)*my_distance);
        yy = orbit_anchor.y - sin(my_angle)*my_distance;
        
        direction = point_direction(x,y,xx,yy);
        speed = 0.5*point_distance(x,y,xx,yy);
    }
    else 
    {
        x = orbit_anchor.x + (cos(my_angle)*my_distance);
        y = orbit_anchor.y - sin(my_angle)*my_distance;
        speed = 0;
    }
}
else
{
    x = my_guy.x;
    y = my_guy.y;
}

if(my_guy == id)
{
    cur_y = y-step-hover_offset;
    light_yoffset = -step-hover_offset;
}
else
{
    cur_y = y;
    light_yoffset = 0;
}

// ORB-ORB INTERACTIONS
if(!invisible && sprite_index != noone && my_color > 0 && instance_exists(orbit_anchor))
{
    // GUY
    if(object_is_ancestor(orbit_anchor.object_index, guy_obj))
    {
        with(color_orb_obj)
        {
            // how the fuck could have "other" been "antenna_obj" here??
            if(id != other.id && orbit_anchor == other.orbit_anchor && !invisible && sprite_index != noone && my_guy != id)
            {
                // LIGHTNING
                if(my_color > 0) // !other.draw_lightning && 
                {
                    if(lightning_target != other.id && my_color != other.my_color)
                    {
                        with(other)
                        {
                            dist = point_distance(x, y, other.x, other.y);
                            if(dist < 96 && !invisible && sprite_index != noone)
                            {
                                draw_lightning = true;
                                lightning_target = other.id;
                                lightning_x = other.x;
                                lightning_y = other.y;
                                lightning_color = my_guy.potential_color;
                                other.receives_lightning = true;
                            }
                        }
                    }
                }
                    
                // RESONANCE
                /*
                if(my_color == other.my_color)
                {
                    with(other)
                    {
                        resonance_level += 0.5;
                    }
                }
                */
            }
        }
        
        // EXTRA ENERGY DISTRIBUTION
        if(orbit_anchor.channeling)
        {
            var i, orb, diff, orb_count = ds_list_size(orbit_anchor.color_slots);
            
            if(orb_count > 1)
            {
                for(i=0;i<orb_count;i++)
                {
                    orb = orbit_anchor.color_slots[| i];
                    if(!is_undefined(orb) && instance_exists(orb) && orb.id != id && orb.my_color == my_color)
                    {
                        if(energy > 1 && orb.energy < 1)
                        {
                            diff = energy - orb.energy; 
                            if(diff >= 2*distribution_step)
                            {
                                orb.direct_input_buffer += distribution_step;
                                energy -= distribution_step;
                            }
                        }
                    }
                }
            }
        }
    
    }
    // CHARGE BALL
    else if(orbit_anchor.object_index == charge_ball_obj)
    {
        // LIGHTNING
        if(my_color > 0 && orbit_anchor.charging) // !other.draw_lightning && 
        {
            dist = point_distance(x, y, orbit_anchor.x, orbit_anchor.y);
            if(dist < 96 && !invisible && sprite_index != noone)
            {
                draw_lightning = true;
                lightning_target = orbit_anchor.id;
                lightning_x = orbit_anchor.x;
                lightning_y = orbit_anchor.y;
                lightning_color = my_color;
                //orbit_anchor.receives_lightning = true;
            }
        }
        
        // EXTRA ENERGY DISTRIBUTION
        var i, orb, diff, orb_count = ds_list_size(orbit_anchor.orbs);
        
        if(orb_count > 1)
        {
            for(i=0;i<orb_count;i++)
            {
                orb = orbit_anchor.orbs[| i];
                if(!is_undefined(orb) && instance_exists(orb) && orb.id != id && orb.my_color == my_color)
                {
                    if(energy > 1 && orb.energy < 1)
                    {
                        diff = energy - orb.energy; 
                        if(diff >= 2*distribution_step)
                        {
                            orb.direct_input_buffer += distribution_step;
                            energy -= distribution_step;
                        }
                    }
                }
            }
        }
        
    }
}

// OBJECT DRAIN
if(instance_exists(drained_object))
{
    var stop_drain = false;
    
    /*
    if(!(drained_object.my_color & my_color))
    {
        stop_drain = true;
    }
    */
    
    var drain_efficiency = min_drain_efficiency;
    if(energy < base_energy)
    {
        drain_efficiency = max_drain_efficiency;
    }
    
    if(!stop_drain)
    {
        if(drained_object.object_index == wall_obj)
        {
            if(holographic == drained_object.holographic)
            {
                if(drained_object.energy > drain_energy_step)
                {
                    drained_object.energy -= drain_energy_step;
                    energy += drain_efficiency*drain_energy_step;
                }
                else if(drained_object.energy > 0)
                {
                    energy += drain_efficiency*drained_object.energy;
                    drained_object.energy = 0;
                    drained_object.my_next_color = g_black;
                
                    stop_drain = true;
                }
            }
        }
        else if(drained_object.object_index == slime_mob_obj)
        {
            if(holographic == drained_object.holographic)
            {
                if(drained_object.energy > drain_energy_step)
                {
                    drained_object.energy -= drain_energy_step;
                    energy += drain_efficiency*drain_energy_step;
                }
                else
                {
                    stop_drain = true;
                }
            }
        }
    }
    
    if(stop_drain)
    {
        drained_object = noone;
        alarm[6] = drain_quick_update_delay;
    }
}
// DRAINED OBJECT DESTROYED
else if(drained_object != noone)
{
    drained_object = noone;
    alarm[6] = drain_quick_update_delay;
}


// RESONANCE
/*
if(resonance_level == 0 || draw_lightning)
{
    temp = 0;
    resonance_step = 0;
    resonance_size_boost = 1;
}
else
{
    var temp = arctan((resonance_step/resonance_cycle - 0.5)*10)/arctan(5);
    resonance_size_boost = 1 + (resonance_level + (temp+1)/2) *resonance_size_coef;
    resonance_step += resonance_stepdir;
    if(resonance_step <= 0)
    {
        resonance_stepdir = 1;
    }
    if(resonance_step >= resonance_cycle)
    {
        resonance_stepdir = -1;
    }
}
*/

size = base_size * size_coef * (0.2 + 0.8*energy/base_energy); // * resonance_size_boost

// PARTICLES

if(!invisible)
{
    part_type_colour1(part_type,self.tint);
    part_type_size(part_type, 0, size, -0.025, 0);
    part_type_alpha1(part_type, holo_alpha);
    part_particles_create(part_system, x, cur_y, part_type, 1);
}

event_inherited();