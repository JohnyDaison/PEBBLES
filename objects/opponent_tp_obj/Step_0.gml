event_inherited();

/// @description TELEPORT BEHAVIOUR
if(active)
{
    var opponent = gamemode_obj.players[? my_guy.my_player.number mod 2 +1];
    var oppo_past_x = opponent.my_guy.xprevious;
    var oppo_past_y = opponent.my_guy.yprevious;
    
    var oppo_state_str = opponent.my_guy.flashback_queue[| 15];
    
    if(!is_undefined(oppo_state_str))
    {
        ds_map_read(oppo_state, oppo_state_str);
        var xx = oppo_state[? "x"];
        var yy = oppo_state[? "y"];
        if(!is_undefined(xx) && !is_undefined(yy))
        {
            oppo_past_x = xx;
            oppo_past_y = yy;     
        }
    }
    
    var x_diff = oppo_past_x - my_guy.x;
    var y_diff = oppo_past_y - my_guy.y;
    
    if(abs(x_diff) > 16)
    {
        my_guy.x += x_diff/2;
    }
    else
    {
        my_guy.x = oppo_past_x;
    }
    
    if(abs(y_diff) > 16)
    {
        my_guy.y += y_diff/2;
    }
    else
    {
        my_guy.y = oppo_past_y;
    }
    
    my_guy.speed = 0;
    
    if(my_guy.x == oppo_past_x && my_guy.y = oppo_past_y)
    {
        active = false;
    }
}
else if(used)
{
    instance_destroy();
}

