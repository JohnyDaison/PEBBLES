/// @description  my_sound_stop(sound)
/// @function  my_sound_stop
/// @param sound
function my_sound_stop(argument0) {
	var sound = argument0;

	if(sound == all)
	{
	    audio_stop_all();
	}
	else if(audio_exists(sound))
	{
	    audio_stop_sound(sound);
	}



}
