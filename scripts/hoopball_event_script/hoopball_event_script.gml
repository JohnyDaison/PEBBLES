function hoopball_event_script(event, source, context_str, params) {
    if(gamemode_obj.limit_reached)
    {
        return;
    }

    if(event == "ballzone_enter")
    {
        var ball = params[? "who"];
        var ballzone = source.zone_id;
        var loser_number = real(string_digits((ballzone)));

        with(player_obj)
        {
            if(number != 0 && team_number != loser_number)
            {
                increase_stat(id, "score", 1, false);
                effect_create_above(ef_firework, ball.x, ball.y, 2, my_guy.tint);
            }
        }
    
        has_ball_number = loser_number;
    }
}
