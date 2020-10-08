/// @description mod_get_state(mod_id)
/// @function mod_get_state
/// @param {string} mod_id
function mod_get_state() {
	var mod_id = argument[0];

	return gamemode_obj.mods_state[? mod_id];


}
