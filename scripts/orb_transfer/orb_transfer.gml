/// @description orb_transfer(orb_obj, from_obj, from_system, to_obj, to_system)
/// @function orb_transfer
/// @param orb_obj
/// @param  from_obj
/// @param  from_system
/// @param  to_obj
/// @param  to_system
function orb_transfer(argument0, argument1, argument2, argument3, argument4) {
	var orb_obj = argument0;
	var from_obj = argument1;
	var from_system = argument2;
	var to_obj = argument3;
	var to_system = argument4;

	if(instance_exists(orb_obj) && instance_exists(from_obj) && instance_exists(to_obj))
	{
	    if(from_obj == to_obj)
	    {
	        if(object_is_ancestor(to_obj.object_index, guy_obj))
	        {
	            if(from_system == "orbit" && to_system == "belt")
	            {
	                guy_orbit_remove(orb_obj.id, from_obj.id);
	                guy_belt_insert(orb_obj.id, to_obj.id);
	            }
	            if(from_system == "belt" && to_system == "orbit")
	            {
	                /*
	                orb_obj.color_added = true;
	                orb_obj.invisible = false;
                
	                var belt = from_obj.orb_belts[? orb_obj.my_color];
	                var index = ds_list_find_index(belt, orb_obj.id)
	                ds_list_delete(belt, index);
	                */
                
	                guy_belt_remove(orb_obj, from_obj)
                
	                guy_orbit_insert(orb_obj, to_obj);
	            }
	        }
	    }
	    else if(object_is_ancestor(from_obj.object_index, guy_obj) && to_obj.object_index == charge_ball_obj)
	    {
	        if(to_system == "orbit")
	        {
	            if(from_system == "belt")
	            {
	                guy_belt_remove(orb_obj, from_obj);
	            }
	            if(from_system == "orbit")
	            {
	                guy_orbit_remove(orb_obj, from_obj);
	            }   
            
	            // ADD TO CHARGEBALL
	            ds_list_add(to_obj.orbs, orb_obj.id);
	            to_obj.orb_count = ds_list_size(to_obj.orbs);
	            orb_obj.orbit_anchor = to_obj.id;
	            orb_obj.tint_updated = false;
	            orb_obj.color_added = true;                 
	            orb_obj.cur_regen_speed = spd_veryslow;
	            if(to_obj.my_color == g_octarine || orb_obj.my_color == g_octarine)
	            {
	                to_obj.my_color = g_octarine;
	            }
	            else
	            {
	                to_obj.my_color |= orb_obj.my_color;
	            }
            
	            //show_debug_message("post-transfer color: " + string(to_obj.my_color));
	            to_obj.tint_updated = false;
            
            
	        }
	    }
	    else if(from_obj.object_index == charge_ball_obj && object_is_ancestor(to_obj.object_index, guy_obj))
	    {
	        if(from_system == "orbit")
	        {
	            var orb_list = from_obj.orbs, i;
	            i = ds_list_find_index(orb_list, orb_obj.id);
            
	            ds_list_delete(orb_list, i);
	            from_obj.orb_count = ds_list_size(orb_list);
            
	            var new_color = g_black;
            
	            for(i=0; i < from_obj.orb_count; i++)
	            {
	                new_color |= orb_list[| i].my_color;
	            }
            
	            from_obj.my_color = new_color;
	            from_obj.tint_updated = false;
            
            
	            if(to_system == "belt")
	            {
	                guy_belt_insert(orb_obj.id, to_obj.id);
	            }
	            else if(to_system == "orbit")
	            {
	                guy_orbit_insert(orb_obj.id, to_obj.id);
	            }
	        }
	    }
	    else if(from_obj.id == orb_obj.id && from_system == "free")
	    {
	        if(object_is_ancestor(to_obj.object_index, guy_obj))
	        {
	            orb_obj.collected = true; 
	            orb_obj.my_guy = to_obj.id;
	            orb_obj.my_player = to_obj.id.my_player;
	            orb_obj.in_use = true;
	            orb_obj.draw_label = false;
	            orb_obj.newly_got_steps = orb_obj.newly_got_anim_duration;
	            ds_list_add(to_obj.orbs_in_use[? orb_obj.my_color], orb_obj.id);
         
	            if(to_system == "belt")
	            {
	                guy_belt_insert(orb_obj.id, to_obj.id);
	            }
	            else if(to_system == "orbit")
	            {
	                guy_orbit_insert(orb_obj.id, to_obj.id);
	            }
	        }
	    }
    
	}




}
