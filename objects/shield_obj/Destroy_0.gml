if(instance_exists(my_guy) && my_guy != id)
{
    var old_guy = my_guy;
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
        var xx, yy;
        
        if(charge > 0 && my_color > g_dark && my_color <= g_white)
        {
            for(var i=0; i<charge; i+=2)
            {
                xx = x + radius * ( random(1) - 0.5 );
                yy = y + radius * ( random(1) - 0.5 );
                var inst = instance_create(xx,yy, slot_explosion_obj);
                inst.my_color = my_color;
                inst.my_source = object_index;
                inst.energy = 5; 
                inst.holographic = holographic;
            }
            
            my_color = g_dark;
            with(old_guy)
            {
                receive_damage(other.charge-other.threshold);
            }
        }
        
        if(charge <= 0 && my_color > g_dark)
        {
            var inst = instance_create(x,y,shield_obj);
            inst.my_player = old_guy.my_player;
            inst.max_charge = self.max_charge + self.overcharge;
            inst.overcharge = 1.5;
            inst.collapse_threshold = inst.max_charge + inst.overcharge;
            
            inst.chargerate = 250;
            inst.charge = inst.max_charge;
            inst.my_color = my_color; 
            inst.my_guy = inst.id;
            inst.my_source = object_index;
            inst.source_id = old_guy.id;
            inst.holographic = holographic;
        }
    }
}

ds_map_destroy(impact_tints);
ds_map_destroy(impact_directions);

part_emitter_destroy(system,em);
part_type_destroy(pt);
part_system_destroy(system);

event_inherited();
