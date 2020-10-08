/// @description find_in_inventory(pickup)
/// @function find_in_inventory
/// @param pickup
function find_in_inventory(argument0) {
	var pickup = argument0;
	var item, byId = false;

	if(instance_exists(pickup))
	{
	    if(pickup == pickup.id)
	    {
	        byId = true;
	    }
	    for(var i=1; i <= inventory_size; i++)
	    {
	        item = inventory[?i];
	        if(instance_exists( item ))
	        {
	            if(item.object_index == pickup.object_index && (!byId || item.id == pickup.id))
	            {
	                return item;
	            }
	        }
	    }
	}

	return noone;



}
