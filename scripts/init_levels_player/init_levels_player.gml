/// @description init_levels_player()
/// @function init_levels_player
function init_levels_player() {

	var i,key,count = ds_list_size(DB.level_list);

	for(i=0; i<count; i++)
	{
	    key = DB.level_list[| i];
    
	    if(is_undefined(levels_roomstart[? key]))
	    {
	        levels_roomstart[? key] = gamemode_obj.level_minstart[? key];
	    }
	    else
	    {
	        levels_roomstart[? key] = clamp( levels_roomstart[? key], 
	                                        gamemode_obj.level_minstart[? key], gamemode_obj.level_maxstart[? key] );
	    }
    
	    if(!is_undefined(levels_roomstart[? key]))
	    {
	        if(is_undefined(levels[? key]))
	        {
	            levels[? key] = levels_roomstart[? key];
	        }
	        else
	        {
	            levels[? key] = clamp( levels[? key],  levels_roomstart[? key], gamemode_obj.level_maxstart[? key] );   
	        }
	    }
	}



}
