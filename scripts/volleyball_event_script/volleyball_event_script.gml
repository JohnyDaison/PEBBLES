/// @description volleyball_event_script(event, source, context_str, params)
/// @function volleyball_event_script
/// @param event
/// @param source
/// @param context_str
/// @param params
function volleyball_event_script(argument0, argument1, argument2, argument3) {
	var event = argument0;
	var source = argument1;
	var context_str = argument2;
	var params = argument3;

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
