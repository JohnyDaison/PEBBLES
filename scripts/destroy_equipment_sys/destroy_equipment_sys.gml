function destroy_equipment_sys() {
    var count = ds_list_size(equipment_list);
    var i, item;
    
    for(i = count - 1; i >= 0; i--)
    {
        item = equipment_list[| i];
        if(!is_undefined(item) && instance_exists(item))
        {
            with(item)
            {
                instance_destroy();
            }
        }
    }
    ds_list_destroy(equipment_list);

    ds_map_destroy(hardpoint_x);
    ds_map_destroy(hardpoint_y);
    ds_map_destroy(hardpoint_type);
    ds_map_destroy(hardpoint_item);
}
