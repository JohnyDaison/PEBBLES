/// @description  my_sound_loop(sound);
/// @function  my_sound_loop
/// @param sound
function my_sound_loop(argument0) {
	var sound = argument0;
	var sound_inst;

	if(audio_exists(sound))
	{
	    sound_inst = audio_play_sound(sound, 0, true);
	}

	return sound_inst;



}
