/// @description levelend_trigger_script(guy)
/// @function levelend_trigger_script
/// @param guy
function levelend_trigger_script() {
	var guy = other.id;

	with(guy)
	{
	    event_perform(ev_collision, level_end_obj);
	}



}
