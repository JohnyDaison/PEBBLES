if(my_player != other.my_player && !destroyed && other.holographic == self.holographic)
{
    //show_debug_message("projectile collision");
    receive_damage(other.force);
}
