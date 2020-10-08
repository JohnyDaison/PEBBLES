function create_debug_keys_map() {
	var map = ds_map_create();

	// anywhere
	map[? "Ctrl + F"] = "Show FPS";
	map[? "Ctrl + J"] = "Show Joystick state (old, ugly)";
	map[? "Ctrl + M"] = "Show Color matrix";
	map[? "Alt + M"] = "Show Minimap (disabled)";
	map[? "Ctrl + C"] = "Show Chunk grid";
	map[? "Alt + L"] = "Show Object labels";
	map[? "Ctrl + L"] = "Draw lights";
	map[? "Hold Alt"] = "Draw test lights and filters";
	map[? "+,-"] = "Change distances between test lights";

	// during game
	map[? "Ctrl + N"] = "Destroy NPCs near cursor (OP, might be buggy)";
	map[? "Alt + C"] = "Make guys near cursor lose control";
	map[? "Ctrl + T"] = "Teleport a player's my_guy to cursor, player is chosen based on cursor color id";
	map[? "Alt + D"] = "Drop terrain near cursor";
	map[? "Alt + W"] = "Deal DoT to walls near cursor";
	map[? "Ctrl + E"] = "Delete terrain and platforms under cursor";
	map[? "Alt + E"] = "Create random color explosion at cursor";
	map[? "Alt + N"] = "Create lightning strike at cursor";
	map[? "Alt + G"] = "Create Smoke at cursor";
	map[? "Ctrl + R"] = "Restart room";
	map[? "Alt + O"] = "Change color of the game object nearest cursor to octarine";
	map[? "Alt + I"] = "Toggle invisibility of the game object nearest cursor";
	map[? "Alt + H"] = "Toggle holographic of the game object nearest cursor";
	map[? "Ctrl + O"] = "Create Orb at cursor, copying its color";
	map[? "Alt + K"] = "Create Sprinkler at cursor";
	map[? "Alt + P"] = "Create Spitter at cursor";
	map[? "Ctrl + D"] = "Create Sprinkler shield at cursor";
	map[? "Ctrl + B"] = "Create CPU guy at cursor";
	map[? "Alt + B"] = "Create Slime at cursor";
	map[? "Ctrl + S"] = "Create Snake on terrain under cursor";
	map[? "Alt + S"] = "Create static Star Core at cursor";
	map[? "Ctrl + W"] = "Create conductive Wall at cursor if location free";
	map[? "Ctrl + A"] = "Create indestructible conductive Wall at cursor if location free";
	map[? "Ctrl + K"] = "Lock conductive wall's color";
	map[? "Ctrl + I"] = "Create indestructible insulator block at cursor if location free";
	map[? "Ctrl + G"] = "Create Grating block at cursor if location free";
	map[? "Ctrl + P"] = "Create Platform at cursor";
	map[? "Alt + T"] = "Create item at cursor (based on cursor color)";
	map[? "Alt + Y"] = "Create upgrade at cursor (based on cursor color)";
	map[? "Alt + A"] = "Create NPC Waypoint at cursor";
	map[? "Numpad 0 - Numpad 8"] = "Change cursor color";
	map[? "Mouse left button"] = "Add energy to wall under cursor, change wall color to cursor's if cursor is not dark";
	map[? "Mouse right button"] = "Remove energy from wall under cursor, change wall color to dark if energy=0";
	map[? "Ctrl + V"] = "Switch views between player cameras and main camera";
	map[? "Alt + U"] = "Restart level with full match loadout";
	map[? "Ctrl + H"] = "Popup data holders' types";

	return map;


}
