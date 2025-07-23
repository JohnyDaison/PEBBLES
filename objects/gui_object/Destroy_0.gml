var size = ds_list_size(self.gui_content);
for (var i = 0; i < size; i++) {
    with (self.gui_content[| i]) {
        instance_destroy();
    }
}

ds_list_destroy(self.gui_content);

if (self.gui_parent != noone) {
    with (self.gui_parent) {
        var childIndex = ds_list_find_index(self.gui_content, other.id);
        ds_list_replace(self.gui_content, childIndex, noone);
    }
}
