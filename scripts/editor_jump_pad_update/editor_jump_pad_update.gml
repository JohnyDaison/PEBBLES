function editor_jump_pad_update() {
	parent_frame.my_pad.max_power = parent_frame.input.value;
	with(parent_frame.my_pad)
	{
	    event_perform(ev_other,ev_user0);
	}
	close_frame(parent_frame);




}
