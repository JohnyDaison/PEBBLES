function destroy_equipment_sys() {
    var count = ds_list_size(self.equipment_list);

    for (var i = count - 1; i >= 0; i--) {
        var item = self.equipment_list[| i];

        if (!is_undefined(item) && instance_exists(item)) {
            instance_destroy(item);
        }
    }

    ds_list_destroy(self.equipment_list);

    ds_map_destroy(self.hardpoint_x);
    ds_map_destroy(self.hardpoint_y);
    ds_map_destroy(self.hardpoint_type);
    ds_map_destroy(self.hardpoint_item);
}
