if(instance_exists(my_guy) && my_guy != id)
{
    old_guy = my_guy;
    my_guy = id;
    old_guy.my_shield = noone;
    old_guy.shield_ready = false;
    old_guy.alarm[4] = round(old_guy.shield_repair_time);
    if(object_is_ancestor(old_guy.object_index, guy_obj))
    {
        old_guy.status_left[? "shield_down"] = old_guy.alarm[4];
    }
    
    if(collapsed)
    {
        var xx, yy, i;
        
        if(charge > 0 && my_color > g_black && my_color <= g_white)
        {
            for(i=0; i<charge; i+=2)
            {
                xx = x + radius * ( random(1) - 0.5 );
                yy = y + radius * ( random(1) - 0.5 );
                i = instance_create(xx,yy, slot_explosion_obj);
                i.my_color = my_color;
                i.my_source = object_index;
                i.energy = 5; 
                i.holographic = holographic;
            }
            
            my_color = g_black;        
            with(old_guy) 
            {
                receive_damage(other.charge-other.threshold);
            }
        }
        
        if(charge <= 0 && my_color > g_black)
        {          
            i = instance_create(x,y,shield_obj);
            i.my_player = old_guy.my_player;
            i.max_charge = self.max_charge + self.overcharge;
            i.overcharge = 1.5;
            i.collapse_threshold = i.max_charge + i.overcharge;
            
            i.chargerate = 250;            
            i.charge = i.max_charge;
            i.my_color = my_color; 
            i.my_guy = i.id;
            i.my_source = object_index;
            i.holographic = holographic;
        }
    }
}

ds_map_destroy(impact_tints);
ds_map_destroy(impact_directions);

part_emitter_destroy(system,em);
part_type_destroy(pt);
part_system_destroy(system);

event_inherited();
