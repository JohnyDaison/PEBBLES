/// @description my_sound_play(sound, [noCorrection], [volume], [pitch])
/// @function my_sound_play
/// @param sound
/// @param [noCorrection]
/// @param [volume]
/// @param [pitch]
function my_sound_play() {
    var sound = argument[0];
    var noCorrection = false;
    var once = false;
    var blocked = false;
    var volume = -1;
    var pitch = -1;
    var sound_inst = noone;

    if(argument_count > 1)
    {
        noCorrection = argument[1];
    }

    if(argument_count > 2)
    {
        volume = argument[2];
    }

    if(argument_count > 3)
    {
        pitch = argument[3];
    }

    if(audio_exists(sound))
    {
        if(sound == channeling_full_sound || sound == cannon_no_ammo_sound)
        {
            once = true;
        }
    
        if(sound == shot_bounce_sound && object_index == energyball_obj && speed < 0.3)
        {
            blocked = true;
        }
    
        if(!blocked)
        {
            if(!once || !audio_is_playing(sound))
            {
                sound_inst = audio_play_sound(sound, 0, false);
                if(volume > 0)
                {
                    audio_sound_gain(sound_inst, volume, 0);
                }
                if(pitch > 0)
                {
                    audio_sound_pitch(sound_inst, pitch);
                }
            }
        
            if(!noCorrection)
            {
                if(sound == wall_hum_sound)
                {
                    singleton_obj.wallhum_buffer += 1;
                }
            
                if(sound == shot_bounce_sound || sound == shot_wallhit_sound || sound == impact_sound)
                {
                    singleton_obj.shots_buffer += 1;
                }
            
                if(sound == guy_bounce_sound || sound == hit_ground_sound)
                {
                    singleton_obj.wallhit_buffer += 1;
                }
            
                if(sound == shield_hit_sound)
                {
                    singleton_obj.shieldhit_buffer += 1;
                }
            }
        }
    }

    /*
    if(sound_inst != noone && DB.console_mode == CONSOLE_MODE.DEBUG)
    {
        my_console_log(object_get_name(object_index) + ":" + string(id) + ": " + audio_get_name(sound))   
    }
    */

    return sound_inst;
}
