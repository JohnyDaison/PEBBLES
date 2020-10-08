/// @description deregister_ds(type, id)
/// @function deregister_ds
/// @param type
/// @param id
function deregister_ds(argument0, argument1) {
	var type = argument0;
	var ds_id = argument1;

	var reg_id = string(type) + string(ds_id);

	var info_map = DB.ds_registry_index[? reg_id];

	var index = ds_list_find_index(DB.ds_registry, info_map);

	ds_map_destroy(info_map);
	ds_list_delete(DB.ds_registry, index);
	ds_map_delete(DB.ds_registry_index, reg_id);



}
