/// @description guy_belt_insert(orb_obj, guy_obj)
/// @function guy_belt_insert
/// @param orb_obj
/// @param  guy_obj
function guy_belt_insert(argument0, argument1) {
	var orb = argument0;
	var guy = argument1;

	var i, count, belt, belt_orb, done=false;

	if(instance_exists(orb) && instance_exists(guy))
	{
	    belt = guy.orb_belts[? orb.my_color];
 
	    if(!is_undefined(belt) && ds_exists(belt, ds_type_list))   
	    {
	        orb.my_guy = guy.id;
	        orb.orbit_anchor = guy.id;   
	        orb.color_added = false;
	        orb.color_held = false;
	        orb.color_consumed = false;
	        orb.invisible = true;
	        orb.sprite_index = noone;
	        orb.cur_regen_speed = spd_slow;
        
	        count = ds_list_size(belt);
	        for(i=0;i<count && !done;i++)
	        {    
	            belt_orb = belt[| i];
	            if(is_undefined(belt_orb) || !instance_exists(belt_orb) || belt_orb.energy < orb.energy)
	            {
	                ds_list_insert(belt, i, orb.id);
	                done = true;
	            }
	        }
	        if(!done && i<guy.belt_size[? orb.my_color])
	        {
	            ds_list_add(belt, orb.id);
	        }
	    }
	}




}
