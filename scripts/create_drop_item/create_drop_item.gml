/// @description create_drop_item(item, body)
/// @function create_drop_item
/// @param item
/// @param body
function create_drop_item() {

	var item = argument[0];
	var body = argument[1];

	var drop_item = instance_create(body.x,body.y, item);
	drop_item.my_guy = body.id;
	drop_item.visible = false;
	drop_item.collected = true;
	drop_item.alarm[0] = -1;
	drop_item.step = 0;
	drop_item.light_yoffset = 0;
	drop_item.hover_offset = 0;
	drop_item.my_player = body.my_player;
	drop_item.fresh = false;

	return drop_item;


}
