function resume_game() {
	singleton_obj.has_unpaused = true;
	room_goto(singleton_obj.paused_room);



}
