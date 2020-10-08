if(image_alpha == 1 && !other.collected)
{
    var hor_dist = abs(x - other.x);
    if(hor_dist < radius)
    {
        /*
        var dmg = (impact_force/anim_damage_steps) * (1 - hor_dist / radius);
        dmg = max(0, dmg);
        */
        
        var dmg = lightning_damage_per_tick(1, hor_dist);
        
        with(other)
        {
            receive_damage(dmg);
        }
    }
}

