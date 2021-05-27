ds_list_destroy(attack_waypoints);

if(instance_exists(charge_ball))
{
    instance_destroy(charge_ball);   
}

if(instance_exists(my_shield))
{
    instance_destroy(my_shield);
}

cleanup_status_effects();
my_sound_stop(full_sound);

instance_destroy(impact_speed_particles);

if(!is_npc)
{
    ds_map_destroy(self.keys);
}

for(i=slot_number-1; i>=0; i-=1)
{
    slot = ds_list_find_value(self.color_slots,i);
    
    instance_destroy(slot);
}

ds_list_destroy(new_colors);
ds_map_destroy(potential_charge);
ds_map_destroy(color_charge);
ds_list_destroy(color_slots);
ds_map_destroy(orb_reserve);

var i,ii,list,orb;
for(i=g_dark; i<=g_blue; i++)
{
    if(i == g_yellow) continue;
    
    list = orb_belts[? i];
    if(!is_undefined(list) && ds_exists(list, ds_type_list))
    {
        ii = ds_list_size(list)-1;
        for(;ii>=0;ii--)
        {
            orb = list[|ii];
            if(instance_exists(orb))
            {
                with(orb)
                {
                    instance_destroy();
                }
            }
        }
        ds_list_destroy(list);
        ds_list_destroy(orbs_in_use[? i]);
    }
}
ds_map_destroy(orb_belts);
ds_map_destroy(orbs_in_use);
ds_map_destroy(belt_size);

ds_map_destroy(inventory);
ds_map_destroy(inv_reserved);

ds_map_destroy(wanna_use);
ds_map_destroy(held_item);
ds_map_destroy(stop_holding);

destroy_equipment_sys();

ds_grid_destroy(climb_sequence);

ds_list_destroy(flashback_queue);
ds_map_destroy(state);
ds_map_destroy(old_state);

ds_map_destroy(abilities);
ds_map_destroy(abi_last_used);
ds_map_destroy(abi_cooldown);
ds_map_destroy(abi_cooldown_length);
ds_map_destroy(abi_script);
ds_map_destroy(abi_last_script);

speech_destroy();

event_inherited();
