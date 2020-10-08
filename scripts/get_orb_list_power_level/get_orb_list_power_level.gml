/// @description get_orb_list_power_level(orb_list)
/// @function get_orb_list_power_level
/// @param orb_list
function get_orb_list_power_level(argument0) {
	var orb_list = argument0;
	var count, orb, orb_energy_total = 0, power_level = -1;

	if(ds_exists(orb_list, ds_type_list))
	{
	    count = ds_list_size(orb_list);
	    if(count > 0)
	    {
	        for(i=0; i<count; i++) 
	        {
	            orb = orb_list[| i];
	            orb_energy_total += orb.energy/orb.base_energy;
	        }
	        power_level = orb_energy_total/count;
	    }
	    else
	    {
	        power_level = 0;
	    }
	}

	return power_level;



}
