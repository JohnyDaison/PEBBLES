if(instance_exists(my_beam))
{
    power_ratio = get_power_ratio(my_beam.my_color,other.my_color);
    if(power_ratio != 0)
    {            
        body_dmg = power_ratio*(my_beam.force/my_beam.big_beam_coef);
        
        other.energy += abs(body_dmg);
        other.beam_end_met = true;        
        
        if((other.damage + body_dmg) < 0)
        {
            body_dmg = -other.damage;       
        }
    
        if(body_dmg != 0)
        {
            other.my_next_color = my_beam.my_color;
            other.tint = my_beam.tint;
            other.damage += body_dmg;
            other.last_dmg += body_dmg;           
            
            i = instance_create(other.x,other.y,damage_popup_obj);
            i.damage = body_dmg;
            i.my_color = my_beam.my_color;
            i.tint = ds_map_find_value(DB.colormap,i.my_color);
            i.tint_updated = true;
            i.source = other.id;
        }
    }
}
else
{
    instance_destroy();
}

