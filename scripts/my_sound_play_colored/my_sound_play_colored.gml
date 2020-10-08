/// @description my_sound_play_colored(sound, color, [noCorrection], [loop], [damage])
/// @function my_sound_play
/// @param sound
/// @param color
/// @param [noCorrection]
/// @param [loop]
/// @param [damage]
function my_sound_play_colored() {

	var sound = argument[0];
	var color = argument[1];
	var noCorrection = false;
	var loop = false;
	var damage = undefined;

	var sound_inst;

	if(argument_count > 2)
	{
	    noCorrection = argument[2];
	}

	if(argument_count > 3)
	{
	    loop = argument[3];
	}

	if(argument_count > 4)
	{
	    damage = argument[4];
	}

	if(loop)
	{
	    sound_inst = my_sound_loop(sound);
	}
	else
	{
	    sound_inst = my_sound_play(sound, noCorrection);
	}
	audio_sound_pitch(sound_inst, DB.colorpitch[? color]);

	return sound_inst;


}
