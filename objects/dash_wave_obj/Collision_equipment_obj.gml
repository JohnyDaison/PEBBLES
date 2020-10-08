if(!fading_out && other.holographic == self.holographic)
{
    with(other)
    {
        if(!unhittable && receive_damage(other.force))
        {
            other.dealt_damage = true;
        }
    }
    has_collided = true;
    
    if(other.object_index == sprinkler_shield_obj && other.my_player != my_player)
    {
       my_guy.charge_ball.dash_interrupted = true;
    }
}

