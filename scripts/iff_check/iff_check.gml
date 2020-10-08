/// @description iff_check(type, this, other)
/// @param type
/// @param self
/// @param other
function iff_check() {

	var type = argument[0];
	var me = argument[1];
	var other_obj = argument[2];

	if(type == "structure_not_enemy")
	{
	    return (other_obj.my_player == gamemode_obj.environment || other_obj.my_player == me.my_player);
	}

	/*
	if(instance_exists(me))
	{
	    my_console_log("me: " + me.name);
	}

	if(instance_exists(other_obj))
	{
	    my_console_log("other_obj: " + other_obj.name);
	}

	if(instance_exists(me))
	{
	    my_console_log("me player: " + string(me.my_player));
	}

	if(instance_exists(other_obj))
	{
	    my_console_log("other_obj player: " + string(other_obj.my_player));
	}
	*/

	var allied = instance_exists(other_obj.my_player) && me.my_player.team_number == other_obj.my_player.team_number;


	if(type == "shield_will_push_me")
	{
	    return (/*other_obj.my_player == me.my_player*/ !allied && other_obj.holographic == me.holographic && !me.protected);
	}


	if(type == "allied")
	{
	    return allied;
	}

	if(type == "not_allied")
	{
	    return !allied;
	}

	if(type == "enemy")
	{
	    return !allied;
	}

	if(type == "attack_target_valid")
	{
	    return (!allied && !other_obj.invisible && me.holographic == other_obj.holographic);
	}

	if(type == "shield_valid")
	{
	    return (!allied && !other_obj.protected && me.holographic == other_obj.holographic);
	}



}
