with(light_emitter_structure_obj)
{
    if(place_meeting(x,y,other))
    {
        my_color = my_color | other.my_color;
        tint_updated = false;
    }
}

instance_destroy();
