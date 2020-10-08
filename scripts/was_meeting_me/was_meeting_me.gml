/// @function was_meeting_me(instance);
/// @param instance
function was_meeting_me() {
	var inst = argument[0];

	var inst_x = inst.x;
	var inst_y = inst.y;
    
	inst.x = inst.xprevious;
	inst.y = inst.yprevious;
    
	var was_meeting = place_meeting(xprevious, yprevious, inst);
    
	inst.x = inst_x;
	inst.y = inst_y;

	return was_meeting;


}
