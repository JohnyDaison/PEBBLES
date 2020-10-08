with(game_obj)
{
    if(last_gravity != gravity)
    {
        if(gravity >= friction)
        {
            var friction_diff = gravity - friction;
            gravity *= other.low_gravity_coef;
            if(gravity < friction)
            {
                gravity = friction + friction_diff * other.low_gravity_coef;
            }
            
        }
        else if(gravity > 0)
        {
            gravity *= other.low_gravity_coef;
        }
        
        last_gravity = gravity;
    }
}