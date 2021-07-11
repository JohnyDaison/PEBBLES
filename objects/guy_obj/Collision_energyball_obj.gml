var projectile = other;

if(!protected && holographic == projectile.holographic)
{
    //show_debug_message("projectile collision");
    var matching_color = instance_exists(my_shield) 
                            && my_shield.my_color == projectile.my_color && projectile.my_color != g_octarine;
    var catalyst_fired_it = projectile.my_source == charge_ball_obj;    
    
    if(is_shielded(id) && (matching_color || catalyst_fired_it))
    {
        // LET SHIELD HANDLE IT
    }
    else
    {
        receive_damage(projectile.force);
    }
}
