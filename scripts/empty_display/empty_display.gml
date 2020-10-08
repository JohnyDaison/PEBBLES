/// @description empty_display(display)
/// @function empty_display
/// @param display
function empty_display(argument0) {
	var disp_obj = argument0;

	if(instance_exists(disp_obj))
	{
	    disp_obj.state = "";
	    disp_obj.sprite = noone;
	    disp_obj.bg_sprite = noone;
	    disp_obj.fg_sprite = noone;
	    disp_obj.sprite_step = 0;
	    disp_obj.sprite_xx = 0;
	    disp_obj.sprite_yy = 0;
	    disp_obj.main_label = "";
	    disp_obj.sub_label = "";
	}



}
