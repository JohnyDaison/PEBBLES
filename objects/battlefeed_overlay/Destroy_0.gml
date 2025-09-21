self.msg_count = ds_list_size(self.msg_list);

for (var i = 0; i < self.msg_count; i += 1) {
    var msg_item = self.msg_list[| i];

    if (!is_string(msg_item) && instance_exists(msg_item)) {
        instance_destroy(msg_item);
    }
}

ds_list_destroy(self.msg_list);

event_inherited();
