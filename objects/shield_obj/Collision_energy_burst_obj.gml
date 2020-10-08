/// @description NORMAL mode
if(instance_exists(my_guy) && my_guy != self.id && !other.done_for && holographic == other.holographic)
{
    var arc = other.id;    
    
    with(arc)
    {
        with(other.my_guy)
        {
            if(!place_meeting(x,y,arc)) // PREVENT DUPLICATE DAMAGE
            {
                receive_damage(other.energy);
            }
        }
    }
}

