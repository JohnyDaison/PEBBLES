if(!fading_out && other.holographic == self.holographic)
{
    var dashwave = id;    
    if(instance_exists(other.my_guy) && other.my_guy != other.id
    && (other.my_player != my_player || my_player == gamemode_obj.environment))
    {
        with(other.my_guy)
        {
            if(!place_meeting(x,y,dashwave)) // PREVENT DUPLICATE DAMAGE
            {
                if(receive_damage(other.force))
                {
                    other.dealt_damage = true;
                }
            }
        }
    }
    
    has_collided = true;
}

