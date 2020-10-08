if(point_distance(x,y, other.x, other.y) < 16 && !other.destroyed)
{
    other.done_for = true;
    other.damage = other.hp;
    instance_destroy();
}

