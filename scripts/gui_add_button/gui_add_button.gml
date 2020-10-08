/// @description gui_add_button(xx, yy, text, script, [repeater]);
/// @function gui_add_button
/// @param xx
/// @param  yy
/// @param  text
/// @param  script
/// @param [repeater]
function gui_add_button() {
	var xx,yy,new_text,new_script,repeater,ii;

	xx = argument[0];
	yy = argument[1];
	new_text = argument[2];
	script = argument[3];

	repeater = false;
	if(argument_count > 4)
	{
	    repeater = argument[4];
	}

	ii = gui_child_init(xx+self.eloffset_x, yy+self.eloffset_y, gui_button);
	ii.text = new_text;

	// WIDTH ADJUSTMENT
	my_draw_set_font(ii.font);
	var text_width = string_width(ii.text);

	while(text_width > ii.width - 32)
	{
	    ii.width += 32; 
	}

	if(repeater)
	{
	    ii.ondown_script = script;
	    ii.onrepeat_script = script; 
	}
	else
	{
	    ii.onup_script = script;
	} 
	ii.repeater = repeater;

	return ii;



}
