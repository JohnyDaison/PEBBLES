if(instance_exists(my_guy) && my_guy != self.id)
{
    if(my_color == other.my_color || other.my_player != my_player)   
    {
        var aoe = other.id; 
        with(aoe)
        {
            with(other.my_guy)
            {
                if(!place_meeting(x,y,aoe)) // PREVENT DUPLICATE DAMAGE
                {
                    if(other.force_used > other.force)
                        other.force_used = other.force;
                    dmg = other.force-other.force_used;
                    if(dmg>0.2)
                        dmg = 0.2;
                    receive_damage(dmg);
                }
            }
        }
    }
}

