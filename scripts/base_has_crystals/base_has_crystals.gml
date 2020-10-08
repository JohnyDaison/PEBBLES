/// @description base_has_crystals()
/// @function base_has_crystals
function base_has_crystals() {
	var result = false;

	//
	if(instance_exists(my_base) && my_base.object_index == guy_spawner_obj && my_base.enabled && my_base.crystal_number > 0)
	{ 
	    result = true;
	}

	return result;


}
