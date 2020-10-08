/// @description play_anim_state_display(display, puppet, state)
/// @function play_anim_state_display
/// @param display
/// @param  puppet
/// @param  state
function play_anim_state_display(argument0, argument1, argument2) {
	var display = argument0;
	var puppet = argument1;
	var state = argument2;

	switch(puppet)
	{
	    case "small_dot":
	        display.bg_sprite = noone;
	        display.sprite = small_dot_spr;
	        display.sprite_step = 0;
	        display.sprite_xx = 0;
	        display.sprite_yy = 0;
	        break;

	    case "color_display":
	        display.bg_sprite = noone;
	        display.sprite = color_display_spr;
	        display.fg_sprite = color_display_highlight_spr;
	        display.main_tint = DB.colormap[? state];
	        display.fg_tint = DB.colormap[? state];
	        if(state == g_octarine)
	        {
	            display.main_tint = singleton_obj.octarine_tint;
	            display.fg_tint = singleton_obj.octarine_tint;
	        }
        
	        display.sprite_step = 0;
	        display.sprite_xx = 0;
	        display.sprite_yy = 0;
	        break;

	    case "color_wheel":
	        display.bg_sprite = noone;
	        display.sprite = color_wheel_scaled5_spr;
	        display.sprite_step = 0;
	        display.sprite_xx = 0;
	        display.sprite_yy = 0;
	        break;

	    case "color_wheel_90gate":
	        display.bg_sprite = noone;
	        display.sprite = color_wheel_90gate_spr;
	        display.sprite_step = 0;
	        display.sprite_xx = 0;
	        display.sprite_yy = 0;
	        break;
        
	    case "color_wheel_180gate":
	        display.bg_sprite = noone;
	        display.sprite = color_wheel_180gate_spr;
	        display.sprite_step = 0;
	        display.sprite_xx = 0;
	        display.sprite_yy = 0;
	        break;
	}


}
