/// @description update_master_volume(volume)
/// @function update_master_volume
/// @param volume
function update_master_volume() {

	var volume = argument[0];

	singleton_obj.master_volume = clamp(volume, 0, 100);
	audio_master_gain(singleton_obj.master_volume/100);


}
