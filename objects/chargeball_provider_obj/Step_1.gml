with(guy_obj)
{
    if(!instance_exists(charge_ball))
    {
        ii = instance_create(x,y,charge_ball_obj);
        ii.my_guy = id;
        ii.my_player = self.my_player;
        charge_ball = ii;
    }
}

