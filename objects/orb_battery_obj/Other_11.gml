effect_create_above(ef_firework,x,y,2,tint);
my_sound_play(pickup_sound);
var total_boost = energy_boost*stack_size;
var i,ii;

for(i=g_red; i<=g_blue; i++)
{
    if(i == g_yellow) continue;
    
    var list = my_guy.orbs_in_use[? i];
    
    if(!is_undefined(list) && ds_exists(list, ds_type_list))
    {
        var count = ds_list_size(list);
        for(ii=0; ii < count; ii++)
        {
            orb = list[|ii];
            if(instance_exists(orb))
            {
                orb.energy = min(orb.energy + total_boost, orb.max_energy);
            }
        }
    }
}
    
i = instance_create(x,y-16,text_popup_obj);
i.str = "POWER+";
i.my_color = my_color;
i.tint_updated = false;

i = create_damage_popup(energy_boost, my_color, id, "energy_recharge");
i.y += 16;

with(overhead_overlay)
{
    if(my_guy == other.my_guy)
    {
        chborbit_blink_time = chborbit_blink_rate*2;
        belts_blink_time = belt_blink_rate*2;
    }
}
