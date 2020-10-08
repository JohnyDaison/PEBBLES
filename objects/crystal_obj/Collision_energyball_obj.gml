if(!collected && instance_exists(my_shield) && holographic == other.holographic)
{
    //show_debug_message("projectile collision");
    receive_damage(other.force);
}

