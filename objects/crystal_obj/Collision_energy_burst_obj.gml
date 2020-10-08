if(!collected && instance_exists(my_shield) && !other.done_for && holographic == other.holographic)
{
    receive_damage(other.energy);
}
