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
    var cannon = instance_create(x,y-128,cannon_base_obj);
    cannon_assign_player(cannon, my_player);
    base_cannon = cannon;
}
