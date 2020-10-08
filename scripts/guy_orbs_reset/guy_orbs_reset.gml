/// @description guy_orbs_reset(guy_obj)
/// @function guy_orbs_reset
/// @param guy_obj
function guy_orbs_reset(argument0) {
	var guy = argument0;
	var count, i, orb, col, list;

	if(instance_exists(guy) && ds_exists(guy.orbs_in_use, ds_type_map))
	{
	    for(col = g_black; col<=g_blue; col++)
	    {
	        if(col == g_yellow)
	            continue;
        
	        list = guy.orbs_in_use[? col];
	        count = ds_list_size(list);
        
	        for(i=count-1; i>=0; i--)
	        {
	            orb = list[|i];
	            if(!is_undefined(orb))
	            {
	                orb.energy = orb.base_energy;
	            }
	            else
	            {
	                show_debug_message(guy.name + "'s Orb " + string(i) + "is undefined!");
	            }
	        }
	    }
	}



}
