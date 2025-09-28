/// @param {Real} arg_count
/// @param {Array} args
function zone_trigger_script(arg_count, args) {
    var count = ds_list_size(self.my_groups);
    var detected_object = noone;

    if (arg_count > 0) {
        detected_object = args[0];
    }

    for (var i = 0; i < count; i++) {
        var group = self.my_groups[| i];
        var key = self.my_keys[? group];

        if (key != "") {
            trigger(place_controller_obj, key, detected_object);
        }
    }
}
