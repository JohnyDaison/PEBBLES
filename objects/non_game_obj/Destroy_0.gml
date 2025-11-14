var count = ds_list_size(self.my_groups);

for(var i = count - 1; i >= 0; i--) {
    group_remove_member(self.my_groups[| i], self.id);
}

ds_list_destroy(self.my_groups);
ds_map_destroy(self.my_keys);
ds_map_destroy(self.transform_memory);
