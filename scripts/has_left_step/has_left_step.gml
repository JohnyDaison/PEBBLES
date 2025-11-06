/// @self projectile_obj
function has_left_step() {
    var count = ds_list_size(self.has_not_left_list);

    for (var index = count - 1; index >= 0; index--) {
        var instance = self.has_not_left_list[| index];

        if (!instance_exists(instance) || !place_meeting(self.x, self.y, instance)) {
            self.has_left_inst[? instance] = true;
            ds_list_delete(self.has_not_left_list, index);
        }
    }
}
