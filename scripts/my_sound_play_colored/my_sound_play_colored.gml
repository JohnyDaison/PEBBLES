/// @description my_sound_play_colored(sound, color, [noCorrection], [volume], [loop])
/// @function my_sound_play_colored
/// @param sound
/// @param color
/// @param [noCorrection]
/// @param [volume]
/// @param [loop]
function my_sound_play_colored() {
    var sound = argument[0];
    var color = argument[1];
    var noCorrection = false;
    var volume = -1;
    var loop = false;

    var sound_inst;

    if(argument_count > 2)
    {
        noCorrection = argument[2];
    }
    
    if(argument_count > 3)
    {
        volume = argument[3];
    }

    if(argument_count > 4)
    {
        loop = argument[4];
    }

    if(loop)
    {
        sound_inst = my_sound_loop(sound);
    }
    else
    {
        sound_inst = my_sound_play(sound, noCorrection, volume, DB.colorpitch[? color]);
    }

    return sound_inst;
}
