if(!protected && !smoke_resistant && holographic == other.holographic)
{
    //show_debug_message("Energy Smoke collision");
    receive_damage(other.force);
}

