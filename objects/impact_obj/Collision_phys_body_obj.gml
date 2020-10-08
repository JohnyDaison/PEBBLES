if(!other.protected && other.id != my_guy && (self.holographic == other.holographic))
{
    var dist = point_distance(x,y,other.x,other.y);
    with(other)
    {
        receive_damage(0.25*other.impact_force*(2-dist/other.inner_radius));
    }
}
