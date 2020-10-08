if(instance_exists(my_guy))
{
    my_guy.forced_channel = false;
    channeling = false;
    channeled = true;
    activated = false;
    /*
    with(platform)
    {
        instance_destroy();
    }
    platform = noone;
    */
    
    // CHARGEBALL
    // shoudn't be needed now
    /*
    if(has_level(my_player, "chargeball", 1))
    {
        if(!instance_exists(my_guy.charge_ball))
        {
            ii = instance_create(x,y,charge_ball_obj);
            ii.my_guy = my_guy.id;
            ii.my_player = self.my_player;
            my_guy.charge_ball = ii;
        }
    }
    */
}
