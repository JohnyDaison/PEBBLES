if(holographic == other.holographic)
{
    var dist = point_distance(x,y,other.x+15,other.y+15);
    var dmg = impact_force*(2-dist/inner_radius)*0.1;
    dmg = max(0,dmg);

    other.damage += dmg;
    other.scale_buffer += 2*dmg;

    if(trigger_terrainfall
        && ( (dist < 56 && impact_force >= terrainfall_threshold && other.cover != cover_indestr)
            || other.unstable ))
    {
        other.falling = true;
    }

    create_damage_popup(dmg, g_black, other.id, "impact");
}
