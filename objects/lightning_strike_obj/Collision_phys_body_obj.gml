if(image_alpha == 1 && !other.protected && other.id != my_guy && (self.holographic == other.holographic))
{
    //var dist = point_distance(x,y,other.x,other.y);
    var dist = abs(x - other.x);
    /*
    var dmg = (impact_force/anim_damage_steps) * (2 - dist / radius);
    dmg = max(0, dmg);
    */
    
    var dmg = lightning_damage_per_tick(2, dist);
    
    with(other)
    {
        receive_damage(dmg);
    }
}
