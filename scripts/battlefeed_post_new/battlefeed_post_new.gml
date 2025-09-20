/// @param {String} type
function battlefeed_post_new(type) {
    var new_item = instance_create(0, 0, battlefeed_item_obj);

    if (!is_undefined(type)) {
        new_item.item_type = type;
    }

    return new_item;
}
