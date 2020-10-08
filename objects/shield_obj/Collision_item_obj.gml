/// @description SHOCKWAVE mode
if(my_guy == id && !other.collected && !other.immovable && holographic == other.holographic)
{
    /*
    dist = point_distance(x,y,other.x,other.y);
    if(dist < inner_radius)
    {
        with(other)
        {
            receive_damage(0.25*other.impact_force*(2-other.dist/other.inner_radius));
        }
    }*/
    apply_force(other.id, true);
}

