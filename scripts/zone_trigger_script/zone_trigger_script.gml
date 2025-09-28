/// @param {Real} arg_count
/// @param {Array} args
function zone_trigger_script(arg_count, args) {
    var detected_object = (arg_count > 0) ? args[0] : noone;
    var group_count = ds_list_size(self.my_groups);

    for (var i = 0; i < group_count; ++i) {
        var group = self.my_groups[| i];
        var key = self.my_keys[? group];

        if (key != "") {
            trigger(place_controller_obj, key, detected_object);
        }
    }
}
