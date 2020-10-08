var opponent = gamemode_obj.players[? my_player.number mod 2 +1];
if(!is_undefined(opponent) && instance_exists(opponent))
{
    var oppo_past_x = opponent.my_guy.x;
    var oppo_past_y = opponent.my_guy.y;
    
    if(point_distance(level_end_obj.x, level_end_obj.y, oppo_past_x, oppo_past_y) > exit_safety_range)
    {
        used = true;
        active = true;
        my_sound_play(artillery_shot_sound);
    }
}

