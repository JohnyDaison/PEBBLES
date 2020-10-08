/// @description  battlefeed_post(whodunnit,verb,victim)
/// @function  battlefeed_post
/// @param whodunnit
/// @param verb
/// @param victim
function battlefeed_post_deprecated() {
	var whodunnit, verb, victim, stat, message_list, name_pos;
	var who_name_str = "", who_player = noone, victim_name_str = "", new_str, new_message = "", feed_item;

	whodunnit = argument[0];
	verb = argument[1];
	victim = argument[2];
	if(argument_count >= 4)
	    stat = argument[3];
	else
	    stat = false;

	message_list = gamemode_obj.battlefeed.msg_list;


	if(whodunnit != noone) {
	    who_name_str = whodunnit.name;
	    who_player = whodunnit.my_player;
	    if(who_name_str != "")
	    {
	        if(!object_is_ancestor(whodunnit.object_index, guy_obj)
	        && whodunnit.object_index != player_obj) // && whodunnit.my_player != gamemode_obj.environment
	        {            
	            who_name_str = whodunnit.my_player.name+"'s "+who_name_str;
	        }
	    }
	    else
	    {
	        if(whodunnit.object_index != player_obj)
	        {
	            who_name_str = whodunnit.my_player.name + "(player)";
	        }
	    }
	}
    
	if(victim == noone)
	{
	    if(!stat)
	        new_message = who_name_str + " "+ verb;
	    else
	        new_message = verb;
	}
	else
	{
	    name_pos = string_pos("%",verb);  
    
	    victim_name_str = victim.name;
	    if(!object_is_ancestor(victim.object_index, guy_obj)
	    && victim.object_index != player_obj) //  && victim.my_player != gamemode_obj.environment
	    {
	        if(whodunnit == victim || who_player == victim.my_player)
	        {
	            victim_name_str = "their own "+victim_name_str;
	        }
	        else
	        {
	            victim_name_str = victim.my_player.name+"'s "+victim_name_str;
	        }
	    }  
    
	    if(name_pos > 0)
	    {
	        new_str = string_replace(verb,"%",victim_name_str);
	        new_message = who_name_str +" "+ new_str;
	    }
	    else
	    {
	        new_message = who_name_str +" "+ verb + " " + victim_name_str;
	    }
	}

	if(stat)
	{
	    var last_index = ds_list_size(message_list)-1;
	    var last_message = message_list[| last_index];
	    if(!is_undefined(last_message) && is_string(last_message)
	    && string_pos(whodunnit.name, last_message) == 1
	    && !string_pos("(", last_message))
	    {
	        last_message += " (" + new_message + ")";
	        message_list[| last_index] = last_message;
	        new_message = "";
	    }
	    else
	    {
	        new_message = who_name_str + "\n" + new_message;    
	    }
	}

	if(new_message != "")
	{
	    //ds_list_add(message_list, new_message);
	    feed_item = battlefeed_post_new();
	    battlefeed_post_assignfeed(feed_item, gamemode_obj.battlefeed);
	    battlefeed_post_add(feed_item, "text", new_message, g_white);
	}
    



}
