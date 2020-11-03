function add_player_overlay(overlay, player) {
	var inst = add_frame(overlay);
	inst.my_player = player;
	inst.my_guy = player.my_guy;

	return inst;
}
