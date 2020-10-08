with(game_obj)
{
    if(last_gravity != gravity)
    {
        gravity *= other.high_gravity_coef;
        
        last_gravity = gravity;
    }
}