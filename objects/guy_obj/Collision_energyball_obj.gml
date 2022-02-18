var projectile = other;

if(!protected && holographic == projectile.holographic)
{
    //show_debug_message("projectile collision");
    if(is_shielded(id))
    {
        // LET SHIELD HANDLE IT
    }
    else
    {
        receive_damage(projectile.force);
    }
}
