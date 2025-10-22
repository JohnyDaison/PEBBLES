/// @param {Real} damage
/// @param {Real} color
/// @param {Id.Instance} source
/// @param {String} type
function create_damage_popup(damage, color, source, type = "normal") {
    var xx = source.x;
    var yy = source.bbox_top;

    if (source.obj_center_offset) {
        xx += lengthdir_x(source.obj_center_dist, source.obj_center_angle + source.image_angle);
    }

    var inst = instance_create(xx, yy, damage_popup_obj);
    inst.damage = damage;
    inst.my_color = color;
    inst.tint_updated = false;
    inst.source = source;
    inst.type = type;

    return inst;
}
