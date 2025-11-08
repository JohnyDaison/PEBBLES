/// @param {String} display_type
/// @param {Real} display_index
/// @param {String} display_id
/// @return {Id.Instance}
function find_display_instance(display_type, display_index, display_id) {
    var instance = noone;

    if (display_type == "index") {
        instance = self.order[? display_index];
    }
    else if (display_type == "id") {
        instance = self.member_ids[? display_id];
    }

    return instance;
}
