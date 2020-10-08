var aurora_count = ds_list_size(other.aurora_list);

with(light_emitter_structure_obj)
{
    if(place_meeting(x,y,other))
    {
        var index = (x div 32 + y div 32) mod aurora_count;
        
        my_color = my_color | other.aurora_list[| index];
        tint_updated = false;
    }
}

instance_destroy();
