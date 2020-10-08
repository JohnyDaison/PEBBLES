if(!fading_out)
{
    with(other)
    {
        if(receive_damage(other.force))
        {   
            event_perform(ev_other,ev_user1);
            speed = 5/6 * speed;
            
            other.dealt_damage = true;
        }
    }
    has_collided = true;
}

