//show_debug_message("soundtime: "+string(soundtime));
//if(charge < max_charge)
my_sound_stop(charge_sound);
//my_sound_stop(full_sound);
/*
if(instance_exists(my_guy))
{
    if(my_guy != id && !return_energy)
    {
        for(c = g_black; c <= g_blue; c+=1) {
            if(c != g_yellow){
                my_guy.energy_left[c] -= energy_cost[c];
                if(energy_cost[c] != 0)
                { 
                    i = instance_create(x+c,y,energy_popup_obj);
                    i.energy = energy_cost[c];
                    i.my_color = c;
                    i.tint_updated = false;
                    i.source = id;
                }
            }
        }
    }
}*/

part_emitter_destroy(system,em);
part_type_destroy(pt);
part_system_destroy(system);

for(i=orb_count-1; i>=0; i-=1)
{
    orb = orbs[|i];
    with(orb)
    {
        instance_destroy();
    }
}
ds_list_destroy(orbs);

/*
if(instance_exists(my_chunkgrid))
{
    observer_remove(my_chunkgrid, id);
}
*/

event_inherited();
