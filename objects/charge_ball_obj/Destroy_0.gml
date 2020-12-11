//show_debug_message("soundtime: "+string(soundtime));
//if(charge < max_charge)
my_sound_stop(charge_sound);
//my_sound_stop(full_sound);

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
