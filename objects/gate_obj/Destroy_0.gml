for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
    if (instance_exists(self.field[? sideIndex])) {
        instance_destroy(self.field[? sideIndex]);
    }
}

for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
    ds_list_destroy(self.tints[? sideIndex]);
}

ds_map_destroy(self.enabled);
ds_map_destroy(self.active);
ds_map_destroy(self.field);
ds_map_destroy(self.tints);

event_inherited();
