enum WatchType {
    Basic,
    Instance,
    Struct,
    DS_List,
    DS_Map
}

function create_watch_types() {
    watch_type_name_list = ds_list_create();
    watch_type_id_list = ds_list_create();
    
    ds_list_add(watch_type_name_list, "Basic", "Instance", "Struct", "DS List", "DS Map");
    ds_list_add(watch_type_id_list, WatchType.Basic, WatchType.Instance, WatchType.Struct, WatchType.DS_List, WatchType.DS_Map);
}