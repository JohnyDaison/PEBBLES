if(!instance_exists(my_strike))
{
    instance_destroy();
    exit;
}

if(my_strike.image_alpha == 1)
{
    //var dist = point_distance(x,y,other.x+15,other.y+15);
    //var dist = max(0, other.x - x) + max(0, x - (other.x + 31));
    var power_ratio = get_power_ratio(my_strike.my_color, other.my_color);

    var dmg = 2 * (my_strike.impact_force/my_strike.anim_damage_steps); //  * (1 - dist/my_strike.radius)
    dmg = power_ratio * max(0, dmg);
    
    if(dmg != 0)
    {
        other.damage += dmg;
        if(!(other.color_locked && other.my_color == g_dark))
        {
            other.energy += abs(dmg);
        }
    
        other.my_next_color = my_strike.my_color;
        other.scale_buffer += 2*dmg;
    
        with(other)
        {
            last_attacker_update(other.id, "body", "damage");
        }

        if(my_strike.trigger_terrainfall
            && ( (dmg >= my_strike.terrainfall_threshold && other.cover != cover_indestr)
                || other.unstable ))
        {
            other.falling = true;
        }

        create_damage_popup(dmg, g_dark, other.id, "lightning_strike");
    }
}