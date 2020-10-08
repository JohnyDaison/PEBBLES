/// @description create_damage_popup(damage, color, source[, type])
/// @function create_damage_popup
/// @param damage
/// @param  color
/// @param  source[
/// @param  type]
function create_damage_popup() {
	var damage = argument[0];
	var color = argument[1];
	var source = argument[2];

	var type = "normal";
	if(argument_count >= 4)
	{
	    type = argument[3];
	}

	var xx = source.x;
	//var yy = source.y;
	var yy = source.bbox_top;
	if(source.obj_center_offset)
	{
	    xx += lengthdir_x(source.obj_center_dist, source.obj_center_angle + source.image_angle);
	    //yy += lengthdir_y(source.obj_center_dist, source.obj_center_angle + source.image_angle);
	}

	var i = instance_create(xx,yy, damage_popup_obj);
	i.damage = damage;
	i.my_color = color;
	i.tint_updated = false;
	i.source = source;
	i.type = type;

	return i;


}
