/// @description speech_start(string_id, [safe], [subject])
/// @function speech_start
/// @param string_id
/// @param [safe]
/// @param [subject]
function speech_start() {
	var strID = argument[0];
	var safe = false;
	var subject = noone;

	if(argument_count > 1)
	{
	    safe = argument[1];
	}

	if(argument_count > 2)
	{
	    subject = argument[2];
	}

	var bbox_y_offset = 56;

	var str = DB.I18n[? strID], str_var;
	var strings = ds_map_create();
	strings[? "name"] = "";
	strings[? "message"] = "";
	strings[? "description"] = "";
	strings[? "comment"] = "";

	// pick string variant
	if(is_undefined(str))
	{
	    str = DB.I18n[? strID+"1"];
    
	    if(!is_undefined(str))
	    {
	        str_var = cur_speech_variant[? strID];
        
	        if(is_undefined(str_var)
	        || is_undefined( DB.I18n[? strID + string(str_var)] ))
	        {
	            cur_speech_variant[? strID] = 1;
	        }
        
	        str = DB.I18n[? strID + string(cur_speech_variant[? strID])];
        
	        cur_speech_variant[? strID]++;
	    }
	}

	// translate string
	if(is_undefined(str))
	{
	    if(safe && DB.console_mode != "debug")
	    {
	        return false;
	    }
	    else
	    {
	        str = "[" + string(strID) + "]";
	    }
	}
	else
	{
	    var stop_count = speech_stop(true);
	    my_console_log("speech_start stopped " + string(stop_count) + " speeches");
    
	    if(instance_exists(subject))
	    {
	        strings[? "name"] = subject.name;

	        if(subject.object_index == SECRET_obj)
	        {
	            strings[? "message"] = subject.message;
	            strings[? "description"] = subject.description;
	            strings[? "comment"] = subject.comment;
	        }
        
	        var key = ds_map_find_first(strings);
	        while(!is_undefined(key))
	        {
	            if(!is_undefined( DB.I18n[? (strings[? key]) ] ))
	            {
	                strings[? key] = DB.I18n[? (strings[? key]) ];
	            }
            
	            key = ds_map_find_next(strings, key);
	        }
        
	    }
	    else
	    {
	        strings[? "name"] = "Subject";
	    }
    
	    var key = ds_map_find_first(strings);
	    while(!is_undefined(key))
	    {
	        str = string_replace_all(str, "$"+key, strings[? key]);
            
	        key = ds_map_find_next(strings, key);
	    }
	}

	// make popup
    if (str != "") {
    	var i = instance_create(x, bbox_top - bbox_y_offset, speech_popup_obj);
    	i.str = str;
    	i.my_color = speech_color;
    	i.source = id;
    	i.y_offset = (bbox_top - bbox_y_offset) - y;

    	self.speech_popup = i;
        self.speaking = true;
    }
    
	self.has_spoken = true;

	ds_map_destroy(strings);

	return true;
}
