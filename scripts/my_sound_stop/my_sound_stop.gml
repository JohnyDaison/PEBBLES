/// @param {Asset.GMSound|Constant.All} sound
function my_sound_stop(sound) {
    if(sound == all)
    {
        audio_stop_all();
    }
    else if(audio_exists(sound))
    {
        audio_stop_sound(sound);
    }
}
