if(!protected && holographic == other.holographic)
{
    //show_debug_message("projectile collision");
    if(is_shielded(id) && my_shield.my_color == other.my_color && other.my_color != g_octarine)
    {
        // LET SHIELD HANDLE IT
    }
    else
    {
        receive_damage(other.force);
    }
    
}

