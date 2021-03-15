/// @description speech_init()
/// @function speech_init
function speech_init() {
    speaking = false;
    has_spoken = false;
    speech_interrupted = false;
    speech_popup = noone;
    speech_tick = DB.npc_speech_tick;
    speech_color = g_azure; //g_white;
    speech_volume = 0.5;
    //speech_pitch = 1;
    label_speaking_alpha = 0.2 * label_alpha;
    label_normal_alpha = label_alpha;

    cur_speech_variant = ds_map_create();
}
