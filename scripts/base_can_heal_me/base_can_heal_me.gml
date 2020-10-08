/// @description base_can_heal_me()
/// @function base_can_heal_me
function base_can_heal_me() {
	var result = false;
            
	if(instance_exists(my_base) && my_base.object_index == guy_spawner_obj && my_base.enabled && my_base.crystal_number > 0 && instance_exists(my_base.my_shield))
	{ 
	    result = true;
	}

	return result;


}
