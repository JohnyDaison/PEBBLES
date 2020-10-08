/// @description crystal_will_be_consumed()
/// @function crystal_will_be_consumed
function crystal_will_be_consumed() {
	var consume = true;
            
	// PREVENTED IF BASE CRYSTAL HAS SPACE
	if(instance_exists(my_base) && my_base.object_index == guy_spawner_obj && my_base.enabled && my_base.crystal_number < my_base.max_crystals)
	{ 
	    consume = false;
	}

	return consume;


}
