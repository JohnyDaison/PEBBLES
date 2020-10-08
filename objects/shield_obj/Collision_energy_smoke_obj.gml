/// @description BOTH modes
if(!other.immovable && holographic == other.holographic) // my_guy == id && 
{
    if(my_guy != id)
    {
        smoke = other.id;
    
        if(is_undefined(smoke.has_left_inst[? id]))
        {
            if(was_meeting_me(smoke))
            {
                with(smoke)
                {
                    has_left_update(other.id, false);
                }
            }
            /*
            else
            {
                with(smoke)
                {
                    has_left_update(other.id, true);
                }
            }*/
        }
    }
    
    if(my_guy == id || has_left_me(smoke))
    {
        apply_force(other, true, false, 0.42);
    }
}
