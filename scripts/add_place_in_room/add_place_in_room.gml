/// @description add_place_in_room(room, name, x,y, width,height, margin);
/// @function add_place_in_room
/// @param room
/// @param  name
/// @param  x
/// @param y
/// @param  width
/// @param height
/// @param  margin
function add_place_in_room(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	var room_id = argument0;
	var name = argument1;
	var xx = argument2;
	var yy = argument3;
	var width = argument4;
	var height = argument5;
	var margin = argument6;

	var place = instance_create(xx,yy,place_obj);
	place.room_id = room_id;
	place.name = name;
	place.width = width;
	place.height = height;
	place.margin = margin;

	place.my_world = id;
	ds_list_add(places, place);

	return place;





}
