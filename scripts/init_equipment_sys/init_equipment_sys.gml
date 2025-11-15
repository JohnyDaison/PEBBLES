function init_equipment_sys() {
    self.hardpoint_count = 0;
    self.hardpoint_x = ds_map_create();
    self.hardpoint_y = ds_map_create();
    self.hardpoint_type = ds_map_create();
    self.hardpoint_item = ds_map_create();
    self.equipment_list = ds_list_create();
}
