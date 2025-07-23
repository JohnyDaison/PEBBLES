/// @param {Asset.GMRoom} room
/// @param {String} name
/// @param {Real} x
/// @param {Real} y
/// @param {Real} width
/// @param {Real} height
/// @param {Real} margin
/// @return {Id.Instance}
function add_place_in_room(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
    var room_id = argument0;
    var name = argument1;
    var xx = argument2;
    var yy = argument3;
    var width = argument4;
    var height = argument5;
    var margin = argument6;

    var place = instance_create(xx, yy, place_obj);
    place.room_id = room_id;
    place.name = name;
    place.width = width;
    place.height = height;
    place.margin = margin;
    
    place.my_world = self.id;
    ds_list_add(self.places, place);

    return place;
}
