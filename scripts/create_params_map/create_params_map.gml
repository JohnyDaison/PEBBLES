function create_params_map(owner = id) {
    var params = ds_map_create();
    
    register_ds("params", ds_type_map, params, owner);

    return params;
}
