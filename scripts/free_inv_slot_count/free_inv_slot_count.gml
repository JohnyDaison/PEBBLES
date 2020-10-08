/// @description free_inv_slot_count()
/// @function free_inv_slot_count
function free_inv_slot_count() {
	var item, result = inventory_size;

	for(var i=1; i <= inventory_size; i++)
	{
	    item = inventory[?i];
	    if(instance_exists( item ))
	    {
	        result--;
	    }
	}

	return result;


}
