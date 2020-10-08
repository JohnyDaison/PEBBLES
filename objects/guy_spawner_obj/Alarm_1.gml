/// @description PLAYER INIT

if(player_start_point)
{
    self.my_player = gamemode_obj.players[? gamemode_obj.inited_player_count+1];

    if(for_player != -1)
    {
        self.my_player = gamemode_obj.players[? for_player];
    }

    if(is_undefined(my_player) || instance_exists(my_player.my_base))
    {
        my_player = noone;
        instance_destroy();
        exit;
    }
    else
    {
        gamemode_obj.inited_player_count += 1;
    }
    
    /*
    my_player.my_spawner = id;
    my_player.my_base = id;
    */
    shield_ready = true;
}


// CANNON
if(has_cannon)
{
    ii = instance_create(x,y-128,cannon_base_obj);
    ii.my_player = self.my_player;
    //ii.my_guy = ii.my_player.my_guy.id;
    base_cannon = ii;
}

/*
// CANNON CHARGEBALL
ii = instance_create(x,y-128,charge_ball_obj);
ii.my_guy = base_cannon.id;
ii.my_player = self.my_player;
ii.bar_height = 12;
base_cannon.charge_ball = ii;
*/

