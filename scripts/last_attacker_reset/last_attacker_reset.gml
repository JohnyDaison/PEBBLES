/// @description last_attacker_reset()
/// @function last_attacker_reset
function last_attacker_reset() {

	last_attacker_map[? "player"] = noone; // instance
	last_attacker_map[? "step"] = 0;
	last_attacker_map[? "source"] = noone; // object_index
	last_attacker_map[? "source_id"] = noone; // instance_id
	last_attacker_map[? "source_name"] = "";
	last_attacker_map[? "source_color"] = g_white;
	last_attacker_map[? "carrier"] = noone; // object_index
	last_attacker_map[? "carrier_color"] = g_white;
	last_attacker_map[? "target"] = ""; //"body"/"shield"



}
