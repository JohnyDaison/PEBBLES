function create_debug_keys_list() {
	var list = ds_list_create();
    
    // anywhere
	ds_list_add(list, {input: "Ctrl + F", label: "Show FPS"});
	ds_list_add(list, {input: "Ctrl + J", label: "Show Joystick state (old, ugly)"});
	ds_list_add(list, {input: "Ctrl + M", label: "Show Color matrix"});
	ds_list_add(list, {input: "Alt + M", label: "Show Minimap (disabled)"});
	ds_list_add(list, {input: "Ctrl + C", label: "Show Chunk grid"});
	ds_list_add(list, {input: "Alt + L", label: "Show Object labels"});
	ds_list_add(list, {input: "Ctrl + L", label: "Draw lights"});
	ds_list_add(list, {input: "Hold Alt", label: "Draw test lights and filters"});
	ds_list_add(list, {input: "+,-", label: "Change distances between test lights"});

	// during game
	ds_list_add(list, {input: "Ctrl + N", label: "Destroy NPCs near cursor (OP, might be buggy)"});
	ds_list_add(list, {input: "Alt + C", label: "Make guys near cursor lose control"});
	ds_list_add(list, {input: "Ctrl + T", label: "Teleport a player's my_guy to cursor, player is chosen based on cursor color id"});
	ds_list_add(list, {input: "Alt + D", label: "Drop terrain near cursor"});
	ds_list_add(list, {input: "Alt + W", label: "Deal damage over time to walls near cursor"});
	ds_list_add(list, {input: "Ctrl + E", label: "Delete terrain and platforms under cursor"});
	ds_list_add(list, {input: "Alt + E", label: "Create random color explosion at cursor"});
	ds_list_add(list, {input: "Alt + N", label: "Create lightning strike at cursor"});
	ds_list_add(list, {input: "Alt + G", label: "Create Smoke at cursor"});
	ds_list_add(list, {input: "Ctrl + R", label: "Restart room"});
	ds_list_add(list, {input: "Alt + O", label: "Change color of the game object nearest cursor to octarine"});
	ds_list_add(list, {input: "Alt + I", label: "Toggle invisibility of the game object nearest cursor"});
	ds_list_add(list, {input: "Alt + H", label: "Toggle holographic of the game object nearest cursor"});
	ds_list_add(list, {input: "Ctrl + O", label: "Create Orb at cursor, copying its color"});
	ds_list_add(list, {input: "Alt + K", label: "Create Sprinkler at cursor"});
	ds_list_add(list, {input: "Alt + P", label: "Create Spitter at cursor"});
	ds_list_add(list, {input: "Ctrl + D", label: "Create Sprinkler shield at cursor"});
	ds_list_add(list, {input: "Ctrl + B", label: "Create CPU guy at cursor"});
	ds_list_add(list, {input: "Alt + B", label: "Create Slime at cursor"});
	ds_list_add(list, {input: "Ctrl + S", label: "Create Snake on terrain under cursor"});
	ds_list_add(list, {input: "Alt + S", label: "Create static Star Core at cursor"});
	ds_list_add(list, {input: "Ctrl + W", label: "Create conductive Wall at cursor if location free"});
	ds_list_add(list, {input: "Ctrl + A", label: "Create indestructible conductive Wall at cursor if location free"});
	ds_list_add(list, {input: "Ctrl + K", label: "Lock conductive wall's color"});
	ds_list_add(list, {input: "Ctrl + I", label: "Create indestructible insulator block at cursor if location free"});
	ds_list_add(list, {input: "Ctrl + G", label: "Create Grating block at cursor if location free"});
	ds_list_add(list, {input: "Ctrl + P", label: "Create Platform at cursor"});
	ds_list_add(list, {input: "Alt + T", label: "Create item at cursor (based on cursor color)"});
	ds_list_add(list, {input: "Alt + Y", label: "Create upgrade at cursor (based on cursor color)"});
	ds_list_add(list, {input: "Alt + A", label: "Create NPC Waypoint at cursor"});
	ds_list_add(list, {input: "Numpad 0 - Numpad 8", label: "Change cursor color"});
	ds_list_add(list, {input: "Mouse left button", label: "Add energy to wall under cursor, change wall color to cursor's if cursor is not dark"});
	ds_list_add(list, {input: "Mouse right button", label: "Remove energy from wall under cursor, change wall color to dark if energy=0"});
	ds_list_add(list, {input: "Ctrl + V", label: "Switch views between player cameras and main camera"});
	ds_list_add(list, {input: "Alt + U", label: "Restart level with full match loadout"});
	ds_list_add(list, {input: "Ctrl + H", label: "Popup data holders' types"});

	return list;
}
