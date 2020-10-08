/// @description last_attacker_update(source, target, type)
/// @function last_attacker_update
/// @param source
/// @param  target
/// @param  type
function last_attacker_update(argument0, argument1, argument2) {
	// target = "body"|"shield"
	// type = "push"|"damage"|"status"
	var source = argument0;
	var target = argument1;
	var type = argument2;

	// TODO: make get_last_attacker_source(source) script

	if(instance_exists(source) && instance_exists(source.my_player) && ds_exists(last_attacker_map, ds_type_map) && (type != "push" || last_attacker_map[? "player"] == noone))
	{
	    last_attacker_reset();
    
	    last_attacker_map[? "player"] = source.my_player;
	    last_attacker_map[? "step"] = singleton_obj.step_count;
    
	    if(type == "push" || type == "fall")
	    {
	        if(object_is_ancestor(source.object_index, guy_obj))
	        {
	            last_attacker_map[? "source"] = guy_obj;
	        }
	        else
	        {   
	            last_attacker_map[? "source"] = source.object_index;
	        }
        
	        last_attacker_map[? "source_id"] = source.id;
	        last_attacker_map[? "source_name"] = source.name;
	        last_attacker_map[? "source_color"] = source.my_color;
        
	        last_attacker_map[? "carrier"] = type;
	        last_attacker_map[? "carrier_color"] = g_white;
	    }
	    else if(type == "damage")
	    {
	        if(instance_exists(source.my_guy))
	        {
	            if(source.my_guy != source)
	            {
	                if(object_is_ancestor(source.my_guy.object_index, guy_obj))
	                {
	                    last_attacker_map[? "source"] = guy_obj;
	                }
	                else
	                {   
	                    last_attacker_map[? "source"] = source.my_guy.object_index;
	                }
                
	                last_attacker_map[? "source_id"] = source.my_guy.id;    
	                last_attacker_map[? "source_color"] = source.my_guy.my_color;
	            }
	            else
	            {
	                if(object_is_ancestor(source.object_index, guy_obj))
	                {
	                    last_attacker_map[? "source"] = guy_obj;
	                }
	                else
	                {   
	                    last_attacker_map[? "source"] = source.object_index;
	                }
                
	                if(source.my_source != noone)
	                {
	                    last_attacker_map[? "source"] = source.my_source;
	                }
	            }
            
	            last_attacker_map[? "source_name"] = source.my_guy.name;
	        }
	        else
	        {
	            last_attacker_map[? "source"] = source.object_index;
	            last_attacker_map[? "source_color"] = source.my_color;
	        }
        
	        if(object_is_ancestor(source.object_index, guy_obj))
	        {
	            last_attacker_map[? "carrier"] = guy_obj;
	        }
	        else
	        {   
	            last_attacker_map[? "carrier"] = source.object_index;
	        }
        
	        if(source.my_source != noone && source.my_source != last_attacker_map[? "source"]
	            && source.my_source != charge_ball_obj && !object_is_child(source.my_source, equipment_obj))
	        {
	            last_attacker_map[? "carrier"] = source.my_source;
	        }
        
	        last_attacker_map[? "carrier_color"] = source.my_color;
	    }
    
	    last_attacker_map[? "target"] = target;
	}



}
