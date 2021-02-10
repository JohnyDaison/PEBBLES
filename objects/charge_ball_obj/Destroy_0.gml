my_sound_stop(my_charge_sound);

part_emitter_destroy(system, em);
part_type_destroy(pt);
part_system_destroy(system);

var i, orb;
for(i = orb_count - 1; i >= 0; i--)
{
    orb = orbs[| i];
    with(orb)
    {
        instance_destroy();
    }
}
ds_list_destroy(orbs);

event_inherited();
