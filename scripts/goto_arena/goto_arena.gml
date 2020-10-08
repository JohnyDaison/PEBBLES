function goto_arena() {
	DB.player_num = 0;
	if(instance_exists(match_obj))
	{
	    if(instance_exists(match_obj.world))
	    {
	        room_goto(match_obj.world.current_place.room_id);
	    }
	    else
	    {
	        room_goto(match_obj.arena);
	    }
	}
	else if(instance_exists(campaign_obj))
	{
	    room_goto(campaign_obj.world.current_place.room_id);
	}



}
