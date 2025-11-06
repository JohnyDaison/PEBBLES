/// @self projectile_obj
/// @param {Id.Instance} instance
/// @param {Bool} value
function has_left_update(instance, value = false) {
    var currentRecordedValue = self.has_left_inst[? instance];
    var currentValue = is_undefined(currentRecordedValue) || currentRecordedValue;

    if (value == false && currentValue) {
        ds_list_add(self.has_not_left_list, instance);
    }
    else if (value == true && !currentValue) {
        ds_list_delete(self.has_not_left_list, ds_list_find_index(self.has_not_left_list, instance));
    }

    self.has_left_inst[? instance] = value;
}
