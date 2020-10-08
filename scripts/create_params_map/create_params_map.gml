///@param [owner]
function create_params_map() {
	var owner = id;
	if(argument_count > 0)
	{
	    owner = argument[0];   
	}

	var params = ds_map_create();
	register_ds("params", ds_type_map, params, owner);

	return params;


}
