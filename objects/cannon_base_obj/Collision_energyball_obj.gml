if(my_player != other.my_player && !destroyed)
{
    //show_debug_message("projectile collision");
    receive_damage(other.force);
}

